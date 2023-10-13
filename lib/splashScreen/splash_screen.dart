import 'dart:async';

import 'package:carpooling_app/authentication/login_screen.dart';
import 'package:carpooling_app/authentication/signup_screen.dart';
import 'package:carpooling_app/mainScreen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:carpooling_app/tabPages/ratings_tab.dart';
import 'package:carpooling_app/tabPages/profile_tab.dart';


import '../authentication/car_info_screen.dart';
import '../global/global.dart';
import '../mainScreen/new_trip_screen.dart';
import '../widgets/fare_amount_collection_dialog.dart';

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
    Timer(const Duration(seconds: 5), () async
    {
      if (await fAuth.currentUser != null) {

        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(context, MaterialPageRoute(builder: (c) => MainScreen()));  //MainScreen()
        //Navigator.push(context, MaterialPageRoute(builder: (c) => NewTripScreen()));

      }
      else {
        Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen())); //LoginScreen()
      }
      //send user to home screen
      //Navigator.push(context, MaterialPageRoute(builder: (c)=> CarInfoScreen()));
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
                Image.asset("images/flash11.jpg"),

                const SizedBox(height: 0,),
              ],
          ),
        ),
      ),
    );
  }
}
