import 'package:carpooling_app/models/directions.dart';
import 'package:flutter/cupertino.dart';
import 'package:carpooling_app/models/directions.dart';
import 'package:carpooling_app/models/trips_history_model.dart';

class AppInfo extends ChangeNotifier
{
  Directions? userPickUpLocation, userDropOffLocation,DriverDestinationLocation;
  int countTotalTrips = 0;
  String driverTotalEarnings="0";
  String driverAverageRatings="0";
  List<String> historyTripsKeysList = [];
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
}