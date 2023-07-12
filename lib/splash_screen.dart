import 'dart:async';

import 'package:financial_record/Views/form_login.dart';
import 'package:financial_record/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    starSplashScreen();
  }

  starSplashScreen() async {
    var duration = const Duration(seconds: 2);

    return Timer(duration, () {
      navigateUser();
    });
  }

  navigateUser() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String name = preferences.getString('name') ?? '';
    final bool isLogin = false;

    if (name.isNotEmpty) {
      runApp(
        const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Navigation(),
        ),
      );
    } else {
      runApp(
        const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FormLogin(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Center(
            child: Image.asset('asset/logo-fr.png'),
          ),
        ),
      ),
    );
  }
}
