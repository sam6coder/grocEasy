import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/splash.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:developer';
import 'screens/home.dart';

late SharedPreferences prefs;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  prefs = await SharedPreferences.getInstance();

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String? start=prefs.getString('logged in');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        useMaterial3: true,
      ),
      home: (FirebaseAuth.instance.currentUser!=null)?start=='login'?HomeScreen():LoginScreen():LoginScreen(),

    );
  }
}

