import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odo_sales_executive/drawer.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Scaffold(
        drawer: Sidebar(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            "My Orders",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: const Color(0xFF2C2455),
        ),
        body:Center(
          child: Text("Orders Screen"),
        )
      ),
    );
  }
}