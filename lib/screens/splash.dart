import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, NavigatorScreen.id);
      });
    } else {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
