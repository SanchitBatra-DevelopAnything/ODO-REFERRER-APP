import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
   Map<String, dynamic>? loggedInReferrer;
   Map<String , dynamic> _referrerCredentials = {};

  Future<void> fetchReferrerAccounts() async {
    print("Fetching referrer accounts...");
  try {
    final url = Uri.parse(
      "https://odo-admin-app-default-rtdb.asia-southeast1.firebasedatabase.app/ReferralLeaderboard.json",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Clear old values before refreshing the map
      _referrerCredentials.clear();

      data.forEach((key, member) {
        final username = member['businessName'];
        if (username != null) {
          // insert: username → member object
          _referrerCredentials[username] = {
            "id": key,
            "password": member["password"],
            "referrals": member["referrals"],
          };
        }
      });

      print(_referrerCredentials);

      notifyListeners();
    } else {
      print("Error status: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
  }
  }

  //write a function to set loggedInReferrer
  //function takes in username and password
  //_referrerCredentials is a map of username to member object
  //if username key is there , set _loggedInReferrer to the value of that key in _referrerCredentials map
  bool loginReferrer(String username, String password) {
    if (_referrerCredentials.containsKey(username)) {
      final member = _referrerCredentials[username];
      if (member != null && member['password'] == password) {
        loggedInReferrer = {
          "username": username,
          "id": member['id'],
          "referrals": member['referrals'],
        };
        notifyListeners();
        return true;
      } else {
        print("Incorrect password for user: $username");
      }
    } else {
      print("Username not found: $username");
    }
    return false;
  }
}