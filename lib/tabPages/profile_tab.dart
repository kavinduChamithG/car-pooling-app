import 'package:carpooling_app/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

import '../infoHandler/app_info.dart';
import '../widgets/info_design_ui.dart';
import 'package:carpooling_app/tabPages/ratings_tab.dart';

class ProfileTabPage extends StatefulWidget
{
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage>
{
 // double ratingsNumber = double.parse(Provider.of<AppInfo>(context, listen: false).driverAverageRatings);
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //name
            Text(
              onlineDriverData.name!,
              style: const TextStyle(
                fontSize: 50.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),


            Text(
              titleStarsRating + " driver",
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.white,
                height: 2,
                thickness: 2,
              ),
            ),

            const SizedBox(height: 38.0,),

            //phone
            InfoDesignUIWidget(
              textInfo: onlineDriverData.phone!,
              iconData: Icons.phone_iphone,
            ),

            //email
            InfoDesignUIWidget(
              textInfo: onlineDriverData.email!,
              iconData: Icons.email,
            ),

            InfoDesignUIWidget(
              textInfo: onlineDriverData.car_color! + " " + onlineDriverData.car_model! + " " +  onlineDriverData.car_number!,
              iconData: Icons.car_repair,
            ),
            // InfoDesignUIWidget(
            //   //textInfo: onlineDriverData.car_color! + " " + onlineDriverData.car_model! + " " +  onlineDriverData.car_number!,
            //   iconData: Icons.star_sharp,
            //
            // ),

            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (c) => RatingsTabPage()));
                await Future.delayed(Duration(seconds: 3)); // Add another delay of 2 seconds


              },
              style: ElevatedButton.styleFrom(
                primary: Colors.yellowAccent,
              ),
              child: const Text(
                "View your Ratings",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            ElevatedButton(
              onPressed: ()
              {
                fAuth.signOut();
                SystemNavigator.pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent,
              ),
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
            )

          ],
        ),
      ),
    );
  }
}
