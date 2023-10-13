import 'dart:async';
import 'package:carpooling_app/mainScreen/Search_destinations_screen.dart';
import 'package:carpooling_app/push_notifications/push_notification_system.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../assistants/assistant_methods.dart';
import '../assistants/black_theme_google_map.dart';
import '../global/global.dart';
import '../global/global.dart';
import '../global/global.dart';
import '../infoHandler/app_info.dart';
import '../main.dart';
import '../splashScreen/splash_screen.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage>
{
  GoogleMapController? newGoogleMapController;
  final Completer<GoogleMapController> _controllerGoogleMap =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );


  var geoLocator = Geolocator();
  LocationPermission? _locationPermission;

  String statusText = "Go Online";  //By default driver is setting to offline
  Color buttonColor = Colors.grey;
  bool isDriverActive = false;

  bool openNavigationDrawer = true;

  TextEditingController destinationTextEditingController = TextEditingController();


  checkIfLocationPermissionAllowed() async
  {
    _locationPermission = await Geolocator.requestPermission();

    if(_locationPermission == LocationPermission.denied)
    {
      _locationPermission = await Geolocator.requestPermission();
    }

  }

  locateDriverPosition() async
  {
    Position cPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    driverCurrentPosition = cPosition;

    LatLng latLngPosition = LatLng(driverCurrentPosition!.latitude, driverCurrentPosition!.longitude);

    CameraPosition cameraPosition = CameraPosition(target: latLngPosition, zoom: 14);

    newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String humanReadableAddress = await AssistantMethods.searchAddressForGeographicCoOrdinates(driverCurrentPosition!, context);
    print("this is your address = " + humanReadableAddress);


    AssistantMethods.readDriverRatings(context);

    //AssistantMethods.readScheduledRideKeys(context);
  }

  readCurrentDriverInformation() async
  {
      currentFirebaseUser = fAuth.currentUser;

      await FirebaseDatabase.instance.ref()
          .child("drivers")
          .child(currentFirebaseUser!.uid)
          .once()
          .then((DatabaseEvent snap)
      {
        if(snap.snapshot.value != null)           //Check the driver is exists or not?
        {
          onlineDriverData.id = (snap.snapshot.value as Map)["id"];
          onlineDriverData.name = (snap.snapshot.value as Map)["name"];
          onlineDriverData.phone = (snap.snapshot.value as Map)["phone"];
          onlineDriverData.email = (snap.snapshot.value as Map)["email"];
          onlineDriverData.car_color = (snap.snapshot.value as Map)["car_details"]["car_color"];
          onlineDriverData.car_model = (snap.snapshot.value as Map)["car_details"]["car_model"];
          onlineDriverData.car_number = (snap.snapshot.value as Map)["car_details"]["car_number"];

          driverVehicleType = (snap.snapshot.value as Map)["car_details"]["type"];

          print("Car Details :: ");
          print(onlineDriverData.car_color);
          print(onlineDriverData.car_model);
          print(onlineDriverData.car_number);
        }
      });

      PushNotificationSystem pushNotificationSystem = PushNotificationSystem();
      pushNotificationSystem.initializeCloudMessaging(context);
      pushNotificationSystem.generateAndGetToken();


      AssistantMethods.readScheduledRideKeys(context);
  }



  @override
  void initState()
  {
    super.initState();

    checkIfLocationPermissionAllowed();
    readCurrentDriverInformation();


    AssistantMethods.readDriverEarnings(context);


  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller)
          {
            _controllerGoogleMap.complete(controller);
            newGoogleMapController = controller;

            //black theme google map
            blackThemeGoogleMap(newGoogleMapController);
            locateDriverPosition();

          },
        ),

        //ui for online offline driver
        statusText != "Now Online"
            ? Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          color: Colors.black87,
        )
            : Container(),



        //button for online offline driver
        Positioned(
          top: statusText != "Now Online"
              ? MediaQuery.of(context).size.height * 0.46
              : 25,
          left: 0,
          right: 0,
          child : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 85, vertical: 18),
           child: Column(
             children: [
               // const Text(
               //   "Where are you going?",
               //   style: TextStyle(
               //     fontSize: 16,
               //     fontWeight: FontWeight.bold,
               //     color: Colors.lightGreenAccent,
               //   ),
               // ),

               const SizedBox(height: 18,),

               GestureDetector(
                 onTap: () async
                 {
                   //go to search places screen
                   var responseFromSearchScreen = await Navigator.push(context, MaterialPageRoute(builder: (c)=> SearchDestinationsScreen()));

                   if(responseFromSearchScreen == "obtainedDropoff")
                   {
                     setState(() {
                       openNavigationDrawer = false;
                     });

                     //draw routes - draw polyline
                     //await drawPolyLineFromOriginToDestination();
                   }
                 },
                 child: Row(
                   children: [
                     const Icon(Icons.add_location_alt_outlined, color: Colors.grey,),
                     const SizedBox(width: 12.0,),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         // const Text(
                         //   "To",
                         //   style: TextStyle(color: Color.fromARGB(255, 219, 136, 12), fontSize: 12),
                         // ),
                         Text(
                           Provider.of<AppInfoc>(context).userDropOffLocation != null
                               ? Provider.of<AppInfoc>(context).userDropOffLocation!.locationName!
                               : "Where are you going?",
                           style: const TextStyle(color: Color.fromARGB(255, 219, 136, 12), fontSize: 18),
                         ),
                       ],
                     ),
                   ],
                 ),
               ),




               // TextField(
               //   key: ValueKey("Destination controller"),
               //   controller: destinationTextEditingController,
               //   decoration: const InputDecoration(
               //     border: OutlineInputBorder(),
               //     filled: true,
               //     fillColor: Colors.white,
               //   ),
               //   style: TextStyle(color: Colors.white, fontSize: 18),
               // ),

               const SizedBox(height: 18,),

           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: ()
                {
                  if(isDriverActive != true) { //offline
                    if (Provider
                        .of<AppInfoc>(context, listen: false)
                        .userDropOffLocation != null) {
                      {
                        driverIsOnlineNow();
                        updateDriversLocationAtRealTime();

                        setState(() {
                          statusText = "Now Online";
                          isDriverActive = true;
                          buttonColor = Colors.transparent;
                        });

                        //display Toast
                        Fluttertoast.showToast(msg: "you are Online Now");
                      }
                    } else {
                      Fluttertoast.showToast(msg: "Please select destination location");
                    }
                  }
                  else //online
                      {
                    driverIsOfflineNow();

                    setState(() {
                      statusText = "Go Online";
                      isDriverActive = false;
                      buttonColor = Colors.grey;
                    });

                    //display Toast
                    Fluttertoast.showToast(msg: "you are Offline Now");
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: buttonColor,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                child: statusText != "Now Online"
                    ? Text(
                  statusText,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
                    : const Icon(
                  Icons.phonelink_ring,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ],
          ),
          ],
          ),
        ),
        ),
      ],
    );
  }

  //To put driver into online status
  driverIsOnlineNow() async
  {
    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    driverCurrentPosition = pos;

    Geofire.initialize("activeDrivers");

    Geofire.setLocation(
        currentFirebaseUser!.uid,
        driverCurrentPosition!.latitude,
        driverCurrentPosition!.longitude
    );

    var driverDestinationLocation = Provider.of<AppInfoc>(context, listen: false).DriverDestinationLocation;

    Map<String, dynamic> driverDestinationLocationMap =
    {
      //"key": value,
      "latitude": driverDestinationLocation!.locationLatitude.toString(),
      "longitude": driverDestinationLocation!.locationLongitude.toString(),
    };

    Map driverDirectionInformationMap =
    {
      "destination": driverDestinationLocationMap,
      "destinationAddress": driverDestinationLocation.locationName,
    };
   // String humanReadableAddress = await AssistantMethods.searchAddressForGeographicCoOrdinates(desPosition!, context);

    DatabaseReference ref1 = FirebaseDatabase.instance.ref()
        .child("drivers")
        .child(currentFirebaseUser!.uid)
        .child("destination");

    DatabaseReference ref = FirebaseDatabase.instance.ref()
        .child("drivers")
        .child(currentFirebaseUser!.uid)
        .child("newRideStatus");

    ref.set("idle"); //searching for ride request
    ref1.set(driverDirectionInformationMap);

    ref.onValue.listen((event) { });
  }

  //Update the divers location realtime in Realtime database
  updateDriversLocationAtRealTime()
  {
    streamSubscriptionPosition = Geolocator.getPositionStream()
        .listen((Position position)
    {
      driverCurrentPosition = position;

      if(isDriverActive == true)
      {
        Geofire.setLocation(
            currentFirebaseUser!.uid,
            driverCurrentPosition!.latitude,
            driverCurrentPosition!.longitude
        );
      }

      LatLng latLng = LatLng(
        driverCurrentPosition!.latitude,
        driverCurrentPosition!.longitude,
      );

      newGoogleMapController!.animateCamera(CameraUpdate.newLatLng(latLng));
    });
  }

  //To make driver in to offline status
  driverIsOfflineNow()
  {
    Geofire.removeLocation(currentFirebaseUser!.uid);

    DatabaseReference? ref = FirebaseDatabase.instance.ref()
        .child("drivers")
        .child(currentFirebaseUser!.uid)
        .child("newRideStatus");

    DatabaseReference? ref1 = FirebaseDatabase.instance.ref()
        .child("drivers")
        .child(currentFirebaseUser!.uid)
        .child("destination");

    ref.onDisconnect();
    ref.remove();

    ref1.onDisconnect();
    ref1.remove();
    ref = null;
    ref1 = null;

    Future.delayed(const Duration(milliseconds: 2000), ()
    {
      //SystemChannels.platform.invokeMethod("SystemNavigator.pop");
      //SystemNavigator.pop();

      //Instead of minimizing the app after going offline, can use one of the following methods to refresh the app fully. 2nd method of loading splash screen can cause small problems as it does not refresh the app fully.
      MyApp.restartApp(context);
      //Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen()));
    });
  }

}
