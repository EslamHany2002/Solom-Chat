
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message_application/Screens/auth/login_screen.dart';
import 'package:message_application/Screens/homePage.dart';




import 'package:message_application/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2) , (){
      final user =  FirebaseAuth.instance.currentUser;
      if(user != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Login_Screen()));
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    mq = MediaQuery.of(context).size;

    return  Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Splach 2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),


    );
  }
}