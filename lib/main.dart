import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:odo_mobile_v2/login.dart';
import 'package:odo_mobile_v2/members.dart';
import 'package:odo_mobile_v2/orders.dart';
import 'package:odo_mobile_v2/providers/member.dart';
import 'package:odo_mobile_v2/providers/order.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MembersProvider()),
        ChangeNotifierProvider(create: (context) => OrdersProvider()),
      ],
      child: const MaterialAppWithInitialRoute(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MaterialAppWithInitialRoute extends StatelessWidget {
  const MaterialAppWithInitialRoute({Key? key}) : super(key: key);

  Future<String> getInitialRoute() async {
    return '/';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getInitialRoute(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final route = snapshot.data?.toString() ?? '/';
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ODO Referrer',
            theme: ThemeData(primarySwatch: Colors.deepPurple),
            initialRoute: route,
            routes: {
              '/': (context) => const Login(),
              '/members': (context) => const Members(),
              '/orders': (context) => const Orders(),
            },
          );
        }

        /// ✅ Loader while app decides initial screen
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
