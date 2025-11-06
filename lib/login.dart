import 'package:flutter/material.dart';
import 'package:odo_sales_executive/providers/auth.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static const Color primaryColor = Color(0xFF2C2455);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isFirstTime = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!mounted) {
      print("Returned back");
      return;
    }
    if (_isFirstTime) {
      Provider.of<AuthProvider>(context, listen: false).fetchReferrerAccounts();
    }
    _isFirstTime = false; //never run the above if again.
    super.didChangeDependencies();
  }

  // ODO Purple
  @override
  Widget build(BuildContext context) {
    //login button only visible when all refs downloaded for login.
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
              Text(
                "Sales Executive Login",
                style: TextStyle(
                  color: Color(0xFF2C2455),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // ✅ Username TextField
              TextField(
                controller: usernameController,
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
                controller: passwordController,
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
              Consumer<AuthProvider>(
                builder: (context, auth, _) {
                  final isEnabled = auth.isReferrerDataLoaded;

                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isEnabled
                            ? Login.primaryColor
                            : Colors.grey,
                      ),
                      onPressed: isEnabled
                          ? () async {
                              final isSuccess = auth.loginReferrer(
                                usernameController.text.trim(),
                                passwordController.text.trim(),
                              );

                              if (isSuccess) {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  "/members",
                                  (route) =>
                                      false, // removes all previous routes
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Invalid username or password",
                                    ),
                                  ),
                                );
                              }
                            }
                          : null, // ❌ disabled while loading
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
