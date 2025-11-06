import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OrdersProvider with ChangeNotifier
{
  Map<String, dynamic> ordersData = {};
  bool isLoading = false;


  Future<void> fetchOrderData(String dateString) async {
  isLoading = true;

  // ✅ clear old data right away
  ordersData = {
    "orders": [],
    "totalAmount": 0.0,
  };
  notifyListeners(); // ✅ UI will instantly show fresh loading state

  try {
    final url = Uri.parse(
      "https://<REGION>-<PROJECT_ID>.cloudfunctions.net/getOrdersForDate?date=$dateString"
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      ordersData = jsonDecode(response.body);
    } else {
      print("Error: ${response.statusCode}");
    }
  } catch (e) {
    print("Exception while fetching orders: $e");
  }

  isLoading = false;
  notifyListeners();
}

}