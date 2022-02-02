import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled1/appRouter.dart';
import 'package:untitled1/data/datasource/local/sharedStore.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => {
      if (SharedStore.getUserToken().isEmpty) {
      Navigator.pushReplacementNamed(context, LOGIN_SIGNUP_ROUTE)
      } else {
      Navigator.pushReplacementNamed(context, POKEMON_LIST_ROUTE)
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset("assets/images/image1.jpg"),
      ),
    );
  }
}
