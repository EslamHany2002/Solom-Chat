import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:message_application/Api/Apis.dart';
import 'package:message_application/Helper/Dialog.dart';
import 'package:message_application/Screens/homePage.dart';
import 'package:message_application/main.dart';

class Login_Screen extends StatefulWidget {
  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  _googleBtncClick() {
    Dialogs.showProgressBar(context);

    _signInWithGoogle().then((user) async {
      Navigator.pop(context);

      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');

        if ((await APIs.userExists())) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          await APIs.creatUser().then((value) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          });
        }
      }
    });
  }

  Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: mq.height*0.13,
          ),
          Center(
              child: Text(
            "Get Started",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          )),
          Center(
              child: Text(
            "Start with login First",
            style: TextStyle(fontSize: 15, color: Colors.black45),
          )),

        Center(child: SvgPicture.asset("assets/Login-amico.svg")),


          Container(
            height: mq.height * 0.07,
            width: mq.width * 0.8,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.black87,
                shape: StadiumBorder(),
                elevation: 1,
              ),
                onPressed: () {
                  // Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>HomePage()));
                  _googleBtncClick();
                },
                icon: Image.asset(
                  'assets/google.png',
                  height: mq.height * 0.045,
                ),
                label: Text("Login with Google",
                    style: TextStyle(color: Colors.white, fontSize: 19))),
          ),
        ],
      ),

      // appBar: AppBar(
      //   backgroundColor: Colors.black38,
      //   elevation: 0.0,
      //   toolbarHeight: 80,
      //   title: Text("Welcome to SolomChat"),
      //   centerTitle: true, systemOverlayStyle: SystemUiOverlayStyle.dark,
      // ),
      // body:ListView(
      //     children: [
      //       Positioned(
      //           top: mq.height * 0.1,
      //           width: mq.width * 0.9,
      //           right: _isAnimate ? mq.width * 0.050 : -mq.width * 0.08,
      //           child: Image.asset('assets/logo 1.png')),
      //       Positioned(
      //         bottom: mq.height * 0.15,
      //         width: mq.width * 0.9,
      //         height: mq.height * 0.07,
      //         left: mq.width * 0.05,
      //         child: ElevatedButton.icon(
      //           style: ElevatedButton.styleFrom(
      //               primary: Colors.black38,
      //               shape: StadiumBorder(),
      //               elevation: 1),
      //           onPressed: () {
      //              Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>HomePage()));
      //             _googleBtncClick();
      //           },
      //           icon: Image.asset('assets/google.png',height: mq.height * 0.045,
      //           ),
      //           label: Text(
      //             "Login with Google",
      //             style: TextStyle(color: Colors.white, fontSize: 19),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
    );
  }
}
