
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:free_book/Screens/location_screen.dart';
import 'package:free_book/Screens/login_screen.dart';
class SplashScreen extends StatefulWidget {

  static const String id = 'splash-screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(
            seconds: 3
        ),(){
      FirebaseAuth.instance.authStateChanges().listen((User? user){
        if(user ==null)
          {
            Navigator.pushReplacementNamed(context, LoginScreen.id);
          }else{
          Navigator.pushReplacementNamed(context, LocationScreen.id);

        }
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('images/free-books.png'),
            SizedBox(height: 10,),


          ],
        ),
      ),
    );
  }
}

