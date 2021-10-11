
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:free_book/Screens/location_screen.dart';
import 'package:free_book/widgets/auth_ui.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login-screen';

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.cyan.shade900,
      body: Column(
        children: [
          Expanded(child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              children: [
                Image.asset('images/free-books.png'),
                SizedBox(height: 10,),

              ],
            ),
          ),),
          Expanded(child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25.0),
            child: AuthUi(),
          ),)
        ],
      ),
    );
  }
}
