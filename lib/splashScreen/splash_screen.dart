import 'dart:async';

import 'package:carpooling_app/authentication/login_screen.dart';
import 'package:carpooling_app/authentication/signup_screen.dart';
import 'package:carpooling_app/mainScreen/main_screen.dart';
import 'package:flutter/material.dart';

import '../global/global.dart';

class MySplashScreen extends StatefulWidget
{
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen>
{
  startTimer()
  {
    Timer(const Duration(seconds: 13), () async
    {
      // if (await fAuth.currentUser != null) {
      //
      //   Navigator.push(context, MaterialPageRoute(builder: (c) => MainScreen()));
      //
      // }
      // else {
      //   Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
      // }
      //send user to home screen
      Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
    }); //Timer
  }

  @override
  void initState() {  //start when we enter a new page
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/splashimage.png"),

                const SizedBox(height: 0,),
              ],
          ),
        ),
      ),
    );
  }
}
