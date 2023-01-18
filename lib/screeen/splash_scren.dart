// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinity_box/auth_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(215, 19, 101, 1),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 200,
              child: Text(
                'Infinity Box',
                style: TextStyle(fontSize: 38, color: Colors.white),
              ),
            ),
            CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
