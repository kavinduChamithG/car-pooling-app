import 'package:carpooling_app/models/directions.dart';
import 'package:flutter/cupertino.dart';
import 'package:carpooling_app/models/directions.dart';
import 'package:carpooling_app/models/trips_history_model.dart';

import '../models/Scheduled_Ride_model.dart';

class AppInfoc extends ChangeNotifier
{
  Directions? userPickUpLocation, userDropOffLocation,DriverDestinationLocation;
  int countTotalTrips = 0;
  int countTotalScheduledRides = 0;
  String driverTotalEarnings="0";
  String driverAverageRatings="0";
  List<String> historyTripsKeysList = [];
  List<String> historyScheduledRideKeysList = [];
  List<ScheduledRideModel> allScheduledRideInformationList = [];
  List<TripsHistoryModel> allTripsHistoryInformationList = [];


  void updatePickUpLocationAddress(Directions userPickUpAddress)
  {
    userPickUpLocation = userPickUpAddress;
    notifyListeners();
  }

  void updateDropOffLocationAddress(Directions dropOffAddress)
  {
    userDropOffLocation = dropOffAddress;
    notifyListeners();
  }

  void updateDriverDestinationAddress(Directions destinationAddress)
  {
    DriverDestinationLocation = destinationAddress;
    notifyListeners();
  }

  updateOverAllTripsCounter(int overAllTripsCounter)
  {
    countTotalTrips = overAllTripsCounter;
    notifyListeners();
  }

  updateOverAllTripsKeys(List<String> tripsKeysList)
  {
    historyTripsKeysList = tripsKeysList;
    notifyListeners();
  }

  updateOverAllTripsHistoryInformation(TripsHistoryModel eachTripHistory)
  {
    allTripsHistoryInformationList.add(eachTripHistory);
    notifyListeners();
  }

  updateDriverTotalEarnings(String driverEarnings)
  {
      driverTotalEarnings = driverEarnings;
  }

  updateDriverAverageRatings(String driverRatings)
  {
    driverAverageRatings = driverRatings;
  }

  updateOverAllScheduledRideCounter(int overAllScheduledRideCounter)
  {
    countTotalScheduledRides = overAllScheduledRideCounter;
    notifyListeners();
  }

  updateOverAllScheduledRideKeys(List<String> scheduledRideKeysList)
  {
    historyScheduledRideKeysList = scheduledRideKeysList;
    notifyListeners();
  }

  updateOverAllScheduledRideHistoryInformation(ScheduledRideModel eachScheduledRideHistory)
  {
    allScheduledRideInformationList.add(eachScheduledRideHistory);
    notifyListeners();
  }

}