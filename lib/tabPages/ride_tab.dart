import 'package:carpooling_app/mainScreen/scheduled_ride_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../authentication/car_info_screen.dart';
import '../global/global.dart';
import '../widgets/progress_dialog.dart';
import 'package:date_time_picker/date_time_picker.dart';

class RideTabPage extends StatefulWidget {
  const RideTabPage({Key? key}) : super(key: key);

  @override
  State<RideTabPage> createState() => _RideTabPageState();
}

class _RideTabPageState extends State<RideTabPage> {

  double searchLocationContainerHeight = 550;

  TextEditingController startPositionTextEditingController = TextEditingController();
  TextEditingController endPositionTextEditingController = TextEditingController();
  TextEditingController dateTextEditingController = TextEditingController();
  TextEditingController timeTextEditingController = TextEditingController();
  TextEditingController seatTextEditingController = TextEditingController();

  DateTime? pickedDate;
  TimeOfDay? pickedTime;
  DatabaseReference? referenceScheduleRideRequest;


  // DatabaseReference? referenceScheduledRide;


  // saveScheduledRideInformation()
  // {
  //   referenceScheduledRide = FirebaseDatabase.instance.ref().child("Scheduled Rides").push();
  //
  //
  //
  // }

  void _pickerDateDialog() async
  {
    pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        const Duration(days: 0),
      ),
      lastDate: DateTime(2100),
    );

    if(pickedDate != null)
    {
      setState(() {
        dateTextEditingController.text = '${pickedDate!.year} - ${pickedDate!.month} - ${pickedDate!.day}';
      });
    }
  }

  void _pickerTimeDialog() async
  {
    pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, childWidget) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              // Using 24-Hour format
                alwaysUse24HourFormat: false),
            // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
            child: childWidget!);
        }
    );

    if(pickedTime != null)
    {
      setState(() {
        //final String myTime = '${pickedTime!.hour}:${pickedTime!.minute} ${pickedTime!.period}';
        timeTextEditingController.text = pickedTime!.format(context);   //
      });
    }
  }


  saveScheduleRideInfo() async
  {
    referenceScheduleRideRequest = FirebaseDatabase.instance.ref().child("Scheduled Rides").push();

    Map scheduledRideDetailMap =
    {
      "id": currentFirebaseUser!.uid,
      "start location": startPositionTextEditingController.text.trim(),
      "end location": endPositionTextEditingController.text.trim(),
      "date": dateTextEditingController.text.trim(),
      "time": timeTextEditingController.text.trim(),
      "seats available" : seatTextEditingController.text.trim(),
    };

    //DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
    referenceScheduleRideRequest!.set(scheduledRideDetailMap);

    Fluttertoast.showToast(msg: "Scheduled Ride has been Posted");
    Navigator.push(context, MaterialPageRoute(builder: (c)=> ScheduledRides()));

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(168, 0, 0, 0), // Set the desired background color
    child: Stack(


    
      children: [
        

                    Row(
                      children: [
                        SizedBox(width: 50),
                        Container(
                            width:300,
                            margin: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                              child: const Text(
                                "Show Schedule Rides",
                              ),
                              onPressed: ()
                              {
                                saveScheduleRideInfo();

                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 219, 136, 12),
                                  foregroundColor: Colors.white,
                                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), // Set a large value for border radius to create an oval shape
                               ),
                              ),
                            ),

                          ),
                      ],
                    ),
        
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
                color: Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                child: Column(
                  children: [

                    

                    Container(
                      padding: const EdgeInsets.all(10),
                      child: (


                        
                        const Text(
                          "Schedule a Future Ride",
                          style:TextStyle(
                              fontSize: 26,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                          )
                        )
                      )
                    ),

                      const SizedBox(height: 10.0),

                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        key: ValueKey("startLocation"),
                        controller: startPositionTextEditingController,
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        // validator: EmailFieldValidator.validate,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Start Location',
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 219, 136, 12),)),
                          filled: true, // Set filled to true
                          fillColor: Color.fromARGB(184, 74, 73, 71),

                        ),
                      ),
                    ),
                

                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        key: ValueKey("endLocation"),
                        controller: endPositionTextEditingController,
                        style: TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'End Location',
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 219, 136, 12),)),
                          filled: true, // Set filled to true
                          fillColor: Color.fromARGB(184, 74, 73, 71),
                        ),
                      ),
                    ),


                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        key: ValueKey("date"),
                        controller: dateTextEditingController,
                        style: TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Date',
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 219, 136, 12),)),
                          filled: true, // Set filled to true
                          fillColor: Color.fromARGB(184, 74, 73, 71),
                        ),
                        readOnly: true,
                        onTap: (){
                          _pickerDateDialog();
                          },
                      ),
                    ),


                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        key: ValueKey("time"),
                        controller: timeTextEditingController,
                        style: TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Departure Time',
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 219, 136, 12),)),
                          filled: true, // Set filled to true
                          fillColor: Color.fromARGB(184, 74, 73, 71),
                        ),
                        readOnly: true,
                        onTap: (){
                          _pickerTimeDialog();
                        },
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        key: ValueKey("seats"),
                        controller: seatTextEditingController,
                        style: TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Seats',
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 219, 136, 12),)),
                          filled: true, // Set filled to true
                          fillColor: Color.fromARGB(184, 74, 73, 71),
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
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Container(
                        width:150,
                        child: ElevatedButton(
                          child: const Text(
                            "Post Ride",
                          ),
                          onPressed: ()
                          {
                            saveScheduleRideInfo();

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 219, 136, 12),
                              foregroundColor: Color.fromARGB(255, 0, 0, 0),
                              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // Set a large value for border radius to create an oval shape
                           ),
                          ),
                        ),

                      ),

  SizedBox(width: 40), // Add some spacing between the buttons
    Container(
      width: 150,
      child: ElevatedButton(
        child: const Text(
          "Reset",
        ),
        onPressed: () {
          // Handle reset button onPressed event
        },
        style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(255, 255, 255, 255),
          onPrimary: Color.fromARGB(255, 0, 0, 0),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ),
                    ],




                    
                  ),

                  ],
                ),
              ),
            ),
          ),
        ),

      ],
    )
    );
    
  }
}
