import 'package:carpooling_app/assistants/request_assistant.dart';
import 'package:carpooling_app/global/global.dart';
import 'package:carpooling_app/global/map_key.dart';
import 'package:carpooling_app/infoHandler/app_info.dart';
import 'package:carpooling_app/models/direction_details_info.dart';
import 'package:carpooling_app/models/directions.dart';
import 'package:carpooling_app/models/trips_history_model.dart';
import 'package:carpooling_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../models/Scheduled_Ride_model.dart';


class AssistantMethods
{
  static Future<String> searchAddressForGeographicCoOrdinates(Position position, context) async
  {
    String apiUrl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapkey";
    String humanReadableAddress="";

    var requestResponse = await RequestAssistant.receiveRequest(apiUrl);

    if(requestResponse != "Error Occurred, Failed. No Response.")
    {
      humanReadableAddress = requestResponse["results"][0]["formatted_address"];

      Directions userPickUpAddress = Directions();
      userPickUpAddress.locationLatitude = position.latitude;
      userPickUpAddress.locationLongitude = position.longitude;
      userPickUpAddress.locationName = humanReadableAddress;

      Provider.of<AppInfoc>(context, listen: false).updatePickUpLocationAddress(userPickUpAddress);
    }

    return humanReadableAddress;
  }


  static Future<DirectionDetailsInfo?> obtainOriginToDestinationDirectionDetails(LatLng origionPosition, LatLng destinationPosition) async
  {
    String urlOriginToDestinationDirectionDetails = "https://maps.googleapis.com/maps/api/directions/json?origin=${origionPosition.latitude},${origionPosition.longitude}&destination=${destinationPosition.latitude},${destinationPosition.longitude}&key=$mapkey";

    var responseDirectionApi = await RequestAssistant.receiveRequest(urlOriginToDestinationDirectionDetails);

    if(responseDirectionApi == "Error Occurred, Failed. No Response.")
    {
      return null;
    }

    DirectionDetailsInfo directionDetailsInfo = DirectionDetailsInfo();
    directionDetailsInfo.e_points = responseDirectionApi["routes"][0]["overview_polyline"]["points"];

    directionDetailsInfo.distance_text = responseDirectionApi["routes"][0]["legs"][0]["distance"]["text"];
    directionDetailsInfo.distance_value = responseDirectionApi["routes"][0]["legs"][0]["distance"]["value"];

    directionDetailsInfo.duration_text = responseDirectionApi["routes"][0]["legs"][0]["duration"]["text"];
    directionDetailsInfo.duration_value = responseDirectionApi["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetailsInfo;
  }

  static pauseLiveLocationUpdates()
  {
    streamSubscriptionPosition!.pause();
    Geofire.removeLocation(currentFirebaseUser!.uid);
  }

  static resumeLiveLocationUpdates()
  {
    streamSubscriptionPosition!.resume();
    Geofire.setLocation(
        currentFirebaseUser!.uid,
        driverCurrentPosition!.latitude,
        driverCurrentPosition!.longitude
    );
  }

  static double calculateFareAmountFromOriginToDestination(DirectionDetailsInfo directionDetailsInfo)
  {
    double timeTraveledFareAmountPerMinute = (directionDetailsInfo.duration_value! / 60) * 5;
    double distanceTraveledFareAmountPerKilometer = (directionDetailsInfo.duration_value!)/1000 * 10.0;

    //rupee
    double totalFareAmount = timeTraveledFareAmountPerMinute + distanceTraveledFareAmountPerKilometer;

    if(driverVehicleType == "bike")
    {
      double resultFareAmount = (totalFareAmount.truncate()) / 2.0;
      return resultFareAmount;
    }
    else if(driverVehicleType == "uber-go")
    {
      return totalFareAmount.truncate().toDouble();
    }
    else if(driverVehicleType == "uber-x")
    {
      double resultFareAmount = (totalFareAmount.truncate()) * 2.0;
      return resultFareAmount;
    }
    else
    {
      return totalFareAmount.truncate().toDouble();
    }
  }

  //retrieve the trips KEYS for online user
  static void readTripsKeysForOnlineDriver(context)
  {
    FirebaseDatabase.instance.ref()
        .child("All Ride Requests")
        .orderByChild("driverId")
        .equalTo(fAuth.currentUser!.uid)
        .once()
        .then((snap)
    {
      if(snap.snapshot.value != null)
      {
        Map keysTripsId = snap.snapshot.value as Map;

        //count total number trips and share it with Provider
        int overAllTripsCounter = keysTripsId.length;
        Provider.of<AppInfoc>(context, listen: false).updateOverAllTripsCounter(overAllTripsCounter);

        //share trips keys with Provider
        List<String> tripsKeysList = [];
        keysTripsId.forEach((key, value)
        {
          tripsKeysList.add(key);
        });
        Provider.of<AppInfoc>(context, listen: false).updateOverAllTripsKeys(tripsKeysList);

        //get trips keys data - read trips complete information
        readTripsHistoryInformation(context);
      }
    });

  }

  static void readTripsHistoryInformation(context)
  {
    var tripsAllKeys = Provider.of<AppInfoc>(context, listen: false).historyTripsKeysList;

    for(String eachKey in tripsAllKeys)
    {
      FirebaseDatabase.instance.ref()
          .child("All Ride Requests")
          .child(eachKey)
          .once()
          .then((snap)
      {
        var eachTripHistory = TripsHistoryModel.fromSnapshot(snap.snapshot);

        if((snap.snapshot.value as Map)["status"] == "ended")
        {
          //update-add each history to OverAllTrips History Data List
          Provider.of<AppInfoc>(context, listen: false).updateOverAllTripsHistoryInformation(eachTripHistory);
        }
      });
    }
  }

  //readDriverEarnings
  static void readDriverEarnings(context)
  {
    FirebaseDatabase.instance.ref()
        .child("drivers")
        .child(fAuth.currentUser!.uid)
        .child("earnings")
        .once()
        .then((snap)
    {
      if(snap.snapshot.value != null)
      {
        String driverEarnings = snap.snapshot.value.toString();
        Provider.of<AppInfoc>(context, listen: false).updateDriverTotalEarnings(driverEarnings);
      }
    });

    readTripsKeysForOnlineDriver(context);
  }


  static void readDriverRatings(context)
  {
    FirebaseDatabase.instance.ref()
        .child("drivers")
        .child(fAuth.currentUser!.uid)
        .child("rating")
        .once()
        .then((snap)
    {
      if(snap.snapshot.value != null)
      {
        String driverRatings = snap.snapshot.value.toString();
        Provider.of<AppInfoc>(context, listen: false).updateDriverAverageRatings(driverRatings);
      }
    });

    readTripsKeysForOnlineDriver(context);
  }



  //retrieve the all Scheduled ride KEYS
  static void readScheduledRideKeys(context)
  {
    FirebaseDatabase.instance.ref()
        .child("Scheduled Rides")
        .once()
        .then((snap)
        //.orderByChild("userName")
        //.equalTo(userModelCurrentInfo!.name)

    {
      if(snap.snapshot.value != null)
      {
        Map keysScheduledRideId = snap.snapshot.value as Map;

        //count total number scheduled rides and share it with Provider
        int overAllScheduledRideCounter = keysScheduledRideId.length;
        Provider.of<AppInfoc>(context, listen: false).updateOverAllScheduledRideCounter(overAllScheduledRideCounter);

        //share trips keys with Provider
        List<String> scheduledRideKeysList = [];
        keysScheduledRideId.forEach((key, value)
        {
          scheduledRideKeysList.add(key);
        });
        Provider.of<AppInfoc>(context, listen: false).updateOverAllScheduledRideKeys(scheduledRideKeysList);

        //get Scheduled rides data - read scheduled complete information
        readScheduledRidesInformation(context);
      }
    });
  }

  static void readScheduledRidesInformation(context)
  {
    var ScheduledRidesAllKeys = Provider.of<AppInfoc>(context, listen: false).historyScheduledRideKeysList;

    for(String eachKey in ScheduledRidesAllKeys)
    {
      FirebaseDatabase.instance.ref()
          .child("Scheduled Rides")
          .child(eachKey)
          .once()
          .then((snap)
      {
        var eachScheduledRideHistory = ScheduledRideModel.fromSnapshot(snap.snapshot);

        Provider.of<AppInfoc>(context, listen: false).updateOverAllScheduledRideHistoryInformation(eachScheduledRideHistory);
        // if((snap.snapshot.value as Map)["status"] == "ended")
        // {
        //   //update-add each history to OverAllScheduledRide History Data List
        //   Provider.of<AppInfoc>(context, listen: false).updateOverAllScheduledRideHistoryInformation(eachScheduledRideHistory);
        // }
      });
    }
  }



}