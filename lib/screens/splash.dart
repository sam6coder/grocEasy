import 'package:flutter/material.dart';
import 'package:groceasy/screens/login.dart';
import 'dart:async';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceasy/screens/home.dart';

late SharedPreferences prefs;

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {

    Timer(Duration(seconds: 10), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      ));
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:40.0),
              child: Center(
                  child: Image.asset("images/logo.png",
                     height:200 )),
            ),
            SizedBox(
                height:50
            ),
            LoadingAnimationWidget.discreteCircle(
                color: CupertinoColors.systemGreen, size: 60),
          ],
        ),
      ),
    );
  }
}
