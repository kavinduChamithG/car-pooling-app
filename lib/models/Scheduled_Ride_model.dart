import 'package:firebase_database/firebase_database.dart';

class ScheduledRideModel
{
  String? id;
  String? name;
  String? time;
  String? date;
  String? start_location;
  String? end_location;
  String? seats_available;
  //String? roughFareAmount;

  ScheduledRideModel({
    this.id,
    this.name,
    this.time,
    this.date,
    this.start_location,
    this.end_location,
    this.seats_available,
    //this.roughFareAmount,
  });

  ScheduledRideModel.fromSnapshot(DataSnapshot dataSnapshot)
  {
    id = (dataSnapshot.value as Map)["id"];
    name = (dataSnapshot.value as Map)["name"];
    time = (dataSnapshot.value as Map)["time"];
    date = (dataSnapshot.value as Map)["date"];
    start_location = (dataSnapshot.value as Map)["start_location"];
    end_location = (dataSnapshot.value as Map)["end_location"];
    seats_available = (dataSnapshot.value as Map)["seats_available"];
    //roughFareAmount = (dataSnapshot.value as Map)["car_details"];
  }
}