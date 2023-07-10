import 'dart:async';

import 'package:carpooling_app/authentication/login_screen.dart';
import 'package:carpooling_app/authentication/signup_screen.dart';
import 'package:carpooling_app/mainScreen/main_screen.dart';
import 'package:carpooling_app/tabPages/Show_shedule_rides.dart';
import 'package:flutter/material.dart';

import '../authentication/car_info_screen.dart';
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
    Timer(const Duration(seconds: 5), () async
    {
      if (await fAuth.currentUser != null) {

        currentFirebaseUser = fAuth.currentUser;
        //Navigator.push(context, MaterialPageRoute(builder: (c) => MainScreen()));
        Navigator.push(context, MaterialPageRoute(builder: (c) => ScheduleTilesPage()));

      }
      else {
        Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
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
