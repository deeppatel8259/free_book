
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:free_book/Screens/authentication/google_auth.dart';
import 'package:free_book/Screens/authentication/phoneauth_screen.dart';
import 'package:free_book/services/phoneauth_service.dart';
import '../Screens/authentication/google_auth.dart';


class AuthUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(

        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 220,

            child: ElevatedButton(
              style:ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(3.0),


              ),),

              onPressed: (){
                Navigator.pushNamed(context, PhoneAuthScreen.id);

              }, child: Row(
                children: [
                  Icon(Icons.phone_android_outlined,color: Colors.black,),
                  SizedBox(width: 8,),
                  Text('Continue with Phone',style: TextStyle(color: Colors.black),),
                ],
              ),),),
          SignInButton(
              Buttons.Google,text : 'Continue with Google',
              onPressed: (){}),
          SignInButton(
            Buttons.FacebookNew,
            text: "Continue with Facebook",
            onPressed: () async{
              User? user = await GoogleAuthentication.signInWithGoogle(context: context);
              if(user!=null){
                //login success
                PhoneAuthService _authentication = PhoneAuthService();
                _authentication.addUser(context, user.uid);
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:Text('OR',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:Text('Login with Email',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,decoration: TextDecoration.underline),),)

        ],
      ),
    );
  }
}
