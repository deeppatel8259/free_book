//import 'package:fb/Screen/authentication/otp_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:free_book/Screens/authentication/otp_screen.dart';
import 'package:free_book/Screens/location_screen.dart';
import 'package:free_book/Screens/login_screen.dart';

class PhoneAuthService{
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(context,uid) async {
    // Call the user's CollectionReference to add a new user

    final QuerySnapshot result = await users.where('uid',isEqualTo: uid).get();

    List <DocumentSnapshot> document = result.docs;

    if(document.length>0){
      Navigator.pushReplacementNamed(context, LocationScreen.id);
    }else{
      return users.doc(user!.uid)
          .set({
        'uid': user!.uid,
        'mobile': user!.phoneNumber, // Stokes and Sons
        'email': user!.email // 42
      })
          .then((value) {
        Navigator.pushReplacementNamed(context, LocationScreen.id);
      })
          .catchError((error) => print("Failed to add user: $error"));
    }


  }

  Future<void>verifyPhoneNumber(BuildContext context, number) async{
    final PhoneVerificationCompleted verificationCompleted = (PhoneAuthCredential credential) async{
      await auth.signInWithCredential(credential);
    };
    final PhoneVerificationFailed phoneVerificationFailed = (FirebaseAuthException e)async{
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }
      print('The errors is ${e.code}');
    };

    final PhoneCodeSent codeSent = (String verId, int? resendToken) async{
      Navigator.push(context, MaterialPageRoute(builder:(context)=>OTPScreen(number: number,verId:verId,)));

    };
    try{
      auth.verifyPhoneNumber(phoneNumber: number,
          verificationCompleted: verificationCompleted,
          verificationFailed: phoneVerificationFailed,
          codeSent: codeSent,
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: (String verificationId){
            print(verificationId);
          });
    }catch(e){
      print('Error ${e.toString()}');
    }
  }
}