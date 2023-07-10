import 'package:carpooling_app/models/directions.dart';
import 'package:flutter/cupertino.dart';


class AppInfo extends ChangeNotifier
{
  Directions? userPickUpLocation, userDropOffLocation, DriverDestinationLocation;


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

}