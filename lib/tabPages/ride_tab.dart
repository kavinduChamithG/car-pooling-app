import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../authentication/car_info_screen.dart';
import '../global/global.dart';
import '../widgets/progress_dialog.dart';

class RideTabPage extends StatefulWidget {
  const RideTabPage({Key? key}) : super(key: key);

  @override
  State<RideTabPage> createState() => _RideTabPageState();
}

class _RideTabPageState extends State<RideTabPage> {

  double searchLocationContainerHeight = 500;

  TextEditingController startPositionTextEditingController = TextEditingController();
  TextEditingController endPositionTextEditingController = TextEditingController();
  TextEditingController dateTextEditingController = TextEditingController();
  TextEditingController timeTextEditingController = TextEditingController();
  TextEditingController seatTextEditingController = TextEditingController();

  // DatabaseReference? referenceScheduledRide;


  // saveScheduledRideInformation()
  // {
  //   referenceScheduledRide = FirebaseDatabase.instance.ref().child("Scheduled Rides").push();
  //
  //
  //
  // }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: AnimatedSize(
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 120),
            child: Container(
              height: searchLocationContainerHeight,
              decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                child: Column(
                  children: [

                    const SizedBox(height: 10.0),

                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        key: ValueKey("startLocation"),
                        controller: startPositionTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        // validator: EmailFieldValidator.validate,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Start Location',
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        key: ValueKey("endLocation"),
                        controller: endPositionTextEditingController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'End Location',
                        ),
                      ),
                    ),


                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        key: ValueKey("date"),
                        controller: dateTextEditingController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Date',
                        ),
                      ),
                    ),


                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        key: ValueKey("time"),
                        controller: timeTextEditingController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Departure Time',
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        key: ValueKey("seats"),
                        controller: seatTextEditingController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Seats',
                        ),
                      ),
                    ),
                    //from
                    // Row(
                    //   children: [
                    //     const Icon(Icons.add_location_alt_outlined, color: Colors.grey,),
                    //     const SizedBox(width: 12.0,),
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         const Text(
                    //           "From",
                    //           style: TextStyle(color: Colors.grey, fontSize: 14),
                    //         ),
                    //         Text(
                    //           "your start location",
                    //           style: const TextStyle(color: Colors.grey, fontSize: 16),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    //
                    // const SizedBox(height: 10.0),
                    //
                    // const Divider(
                    //   height: 1,
                    //   thickness: 1,
                    //   color: Colors.grey,
                    // ),
                    //
                    // const SizedBox(height: 16.0),
                    //
                    // //to
                    // Row(
                    //   children: [
                    //     const Icon(Icons.add_location_alt_outlined, color: Colors.grey,),
                    //     const SizedBox(width: 12.0,),
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         const Text(
                    //           "To",
                    //           style: TextStyle(color: Colors.grey, fontSize: 14),
                    //         ),
                    //         Text(
                    //           "Where to go?",
                    //           style: const TextStyle(color: Colors.grey, fontSize: 16),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    //
                    // const SizedBox(height: 10.0),
                    //
                    // const Divider(
                    //   height: 1,
                    //   thickness: 1,
                    //   color: Colors.grey,
                    // ),
                    //
                    // const SizedBox(height: 10.0),
                    // //Date
                    // Row(
                    //   children: [
                    //     const Icon(Icons.date_range_rounded, color: Colors.grey,),
                    //     const SizedBox(width: 12.0,),
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         const Text(
                    //           "Date",
                    //           style: TextStyle(color: Colors.grey, fontSize: 14),
                    //         ),
                    //         Text(
                    //           "When you go?",
                    //           style: const TextStyle(color: Colors.grey, fontSize: 16),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    //
                    // const SizedBox(height: 10.0),
                    //
                    // const Divider(
                    //   height: 1,
                    //   thickness: 1,
                    //   color: Colors.grey,
                    // ),
                    //
                    // const SizedBox(height: 16.0),
                    //
                    // Row(
                    //   children: [
                    //     const Icon(Icons.access_time, color: Colors.grey,),
                    //     const SizedBox(width: 12.0,),
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         const Text(
                    //           "Depature Time",
                    //           style: TextStyle(color: Colors.grey, fontSize: 14),
                    //         ),
                    //         Text(
                    //           "At what time you start the ride?",
                    //           style: const TextStyle(color: Colors.grey, fontSize: 16),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    //
                    // const SizedBox(height: 10.0),
                    //
                    // const Divider(
                    //   height: 1,
                    //   thickness: 1,
                    //   color: Colors.grey,
                    // ),
                    //
                    // const SizedBox(height: 16.0),

                    ElevatedButton(
                      child: const Text(
                        "Request a Ride",
                      ),
                      onPressed: ()
                      {

                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                      ),
                    ),



                  ],
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
