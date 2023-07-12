import 'package:financial_record/Views/form_login.dart';
import 'package:financial_record/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

var routes = <String, WidgetBuilder>{
  "/auth": (BuildContext context) => FormLogin(),
};
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Demo',
      routes: routes,
      home: SplashScreen(),
    ),
  );
}

// class Main extends StatelessWidget {
//   const Main({super.key});

//   @override
//   Widget build(BuildContext context) {
//      WidgetsFlutterBinding.ensureInitialized();
//      await Firebase.initializeApp();
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       routes: routes,
//       home: SplashScreen(),
//     );
//   }
// }
