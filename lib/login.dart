import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  static const Color primaryColor = Color(0xFF2C2455); // ODO Purple

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ✅ Logo centered
              Image.asset(
                'assets/logo.jpeg', // make sure this path is correct
                height: 120,
              ),
              const SizedBox(height: 20),
              Text("Sales Executive Login" , style: TextStyle(color: Color(0xFF2C2455) , fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              // ✅ Username TextField
              TextField(
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ✅ Password TextField
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // ✅ Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/orders'); // example action
                  },
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // text color ✅
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
