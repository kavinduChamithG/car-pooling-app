import 'package:flutter/material.dart';

import '../widgets/custom_text.dart';

class ScheduledRides extends StatefulWidget {
  const ScheduledRides({Key? key}) : super(key: key);

  @override
  State<ScheduledRides> createState() => _ScheduledRidesState();
}

class _ScheduledRidesState extends State<ScheduledRides> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Schedule Rides'),
          backgroundColor: Color.fromARGB(255, 219, 136, 12),
          centerTitle: true,
        ), //AppBar
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        body: Align(
          alignment: Alignment.topCenter,
          /* Card Widget */
          child: Card(
            elevation: 10,
            shadowColor: Colors.black,
            color: Color.fromARGB(184, 74, 73, 71),
            child: SizedBox(
              width: 400,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //CircleAvatar(
                    //backgroundColor: Colors.green[500],
                    //radius: 108,
                    //child: const CircleAvatar(
                    //backgroundImage: NetworkImage(
                    //"https://media.geeksforgeeks.org/wp-content/uploads/20210101144014/gfglogo.png"), //NetworkImage
                    // radius: 100,
                    //), //CircleAvatar
                    //), //CircleAvatar
                    //const SizedBox(
                    //height: 5,
                    //), //SizedBox
                    Text(
                      'Namal Kumara',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w500,
                      ), //Textstyle
                    ), //Text
                    const SizedBox(
                      height: 10,
                    ), //SizedBox
                    Row(
                      children: [
                        const Text(
                          'Start Location : Galle',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color.fromARGB(255, 219, 136, 12),

                          ), //Textstyle

                        ), //Text


                        const SizedBox(
                          width: 50,
                        ),

                        const Text(
                          'End Location  : Colombo',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color.fromARGB(255, 219, 136, 12),

                          ), //Textstyle

                        ),
                      ],
                    ), //SizedBox

                    const Text(
                      'Date                 : 20/07/2023',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color.fromARGB(255, 219, 136, 12),

                      ), //Textstyle

                    ),

                    Row(
                      children: [
                        const Text(
                          'Time                : 10:30',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color.fromARGB(255, 219, 136, 12),

                          ), //Textstyle

                        ),

                        const SizedBox(
                          width: 75,
                        ),

                        const Text(
                          'No. Seats        : 2',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color.fromARGB(255, 219, 136, 12),

                          ), //Textstyle
                        ),
                      ],
                    ),


                    const SizedBox(
                      height: 10,
                    ), //


                    SizedBox(
                      width: 120,
                      height: 32,

                      child: ElevatedButton(
                        onPressed: () => 'Null',
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Color.fromARGB(255, 219, 136, 12))),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            children: const [
                              Icon(Icons.touch_app),
                              Text('More...',
                                style: TextStyle(color: Colors.black),)
                            ],
                          ),
                        ),
                      ),
                      // RaisedButton is deprecated and should not be used
                      // Use ElevatedButton instead

                      // child: RaisedButton(
                      //   onPressed: () => null,
                      //   color: Colors.green,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(4.0),
                      //     child: Row(
                      //       children: const [
                      //         Icon(Icons.touch_app),
                      //         Text('Visit'),
                      //       ],
                      //     ), //Row
                      //   ), //Padding
                      // ), //RaisedButton
                    ) //SizedBox
                  ],
                ), //Column
              ), //Padding
            ), //SizedBox
          ),
        ), //Center
      ),



    ); //MaterialApp;
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       //color: Colors.amber,
//       child: SafeArea(
//         child: DefaultTabController(
//           length: 2,
//           child: Column(
//             children: const [
//               TabBar(
//                 // controller: _tabController,
//                 indicatorColor: Colors.cyan,
//                 labelColor: Colors.indigo,
//                 dividerColor: Colors.brown,
//                 tabs: [
//                   Tab(
//                     icon: Icon(Icons.directions_car),
//                     child: Text("Posted"),
//                   ),
//                   Tab(
//                     icon: Icon(Icons.request_page_sharp),
//                     child: Text("Requested"),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: TabBarView(
//                   children: [
//
//
//                     //PostedRides(),
//                     //RequestedRides(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// Future<Widget> scheduleTiles(BuildContext context)
// async {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Schedule Rides'),
//           backgroundColor: Color.fromARGB(255, 219, 136, 12),
//           centerTitle: true,
//         ), //AppBar
//         backgroundColor: Color.fromARGB(255, 0, 0, 0),
//         body: Align(
//           alignment: Alignment.topCenter,
//           /* Card Widget */
//           child: Card(
//             elevation: 10,
//             shadowColor: Colors.black,
//             color: Color.fromARGB(184, 74, 73, 71),
//             child: SizedBox(
//               width: 400,
//               height: 150,
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     //CircleAvatar(
//                     //backgroundColor: Colors.green[500],
//                     //radius: 108,
//                     //child: const CircleAvatar(
//                     //backgroundImage: NetworkImage(
//                     //"https://media.geeksforgeeks.org/wp-content/uploads/20210101144014/gfglogo.png"), //NetworkImage
//                     // radius: 100,
//                     //), //CircleAvatar
//                     //), //CircleAvatar
//                     //const SizedBox(
//                     //height: 5,
//                     //), //SizedBox
//                     Text(
//                       'Namal Kumara',
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: Color.fromARGB(255, 255, 255, 255),
//                         fontWeight: FontWeight.w500,
//                       ), //Textstyle
//                     ), //Text
//                     const SizedBox(
//                       height: 10,
//                     ), //SizedBox
//                     Row(
//                       children: [
//                         const Text(
//                           'Star Location : Rathnapura',
//                           style: TextStyle(
//                             fontSize: 10,
//                             color: Color.fromARGB(255, 219, 136, 12),
//
//                           ), //Textstyle
//
//                         ), //Text
//
//
//                         const SizedBox(
//                           width: 50,
//                         ),
//
//                         const Text(
//                           'End Location  : Colombo',
//                           style: TextStyle(
//                             fontSize: 10,
//                             color: Color.fromARGB(255, 219, 136, 12),
//
//                           ), //Textstyle
//
//                         ),
//                       ],
//                     ), //SizedBox
//
//                     const Text(
//                       'Date                 : 20/07/2023',
//                       style: TextStyle(
//                         fontSize: 10,
//                         color: Color.fromARGB(255, 219, 136, 12),
//
//                       ), //Textstyle
//
//                     ),
//
//                     Row(
//                       children: [
//                         const Text(
//                           'Time                : 10:30',
//                           style: TextStyle(
//                             fontSize: 10,
//                             color: Color.fromARGB(255, 219, 136, 12),
//
//                           ), //Textstyle
//
//                         ),
//
//                         const SizedBox(
//                           width: 75,
//                         ),
//
//                         const Text(
//                           'No. Seats        : 2',
//                           style: TextStyle(
//                             fontSize: 10,
//                             color: Color.fromARGB(255, 219, 136, 12),
//
//                           ), //Textstyle
//                         ),
//                       ],
//                     ),
//
//
//                     const SizedBox(
//                       height: 10,
//                     ), //
//
//
//                     SizedBox(
//                       width: 120,
//                       height: 32,
//
//                       child: ElevatedButton(
//                         onPressed: () => 'Null',
//                         style: ButtonStyle(
//                             backgroundColor:
//                             MaterialStateProperty.all(Color.fromARGB(255, 219, 136, 12))),
//                         child: Padding(
//                           padding: const EdgeInsets.all(4),
//                           child: Row(
//                             children: const [
//                               Icon(Icons.touch_app),
//                               Text('More...',
//                                 style: TextStyle(color: Colors.black),)
//                             ],
//                           ),
//                         ),
//                       ),
//                       // RaisedButton is deprecated and should not be used
//                       // Use ElevatedButton instead
//
//                       // child: RaisedButton(
//                       //   onPressed: () => null,
//                       //   color: Colors.green,
//                       //   child: Padding(
//                       //     padding: const EdgeInsets.all(4.0),
//                       //     child: Row(
//                       //       children: const [
//                       //         Icon(Icons.touch_app),
//                       //         Text('Visit'),
//                       //       ],
//                       //     ), //Row
//                       //   ), //Padding
//                       // ), //RaisedButton
//                     ) //SizedBox
//                   ],
//                 ), //Column
//               ), //Padding
//             ), //SizedBox
//           ),
//         ), //Center
//       ),
//
//
//
//     ); //MaterialApp;
//   }
// }
//
//
// Widget postedRideItem(BuildContext context) {
//   return GestureDetector(
//     // onTap: () {
//     //   Get.to(() => PostedRideInfo(
//     //     ride: ride,
//     //   ));
//     // },
//     child: Container(
//       padding: EdgeInsets.all(10),
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         // border: Border.all(width: 0.5),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 3,
//             // offset: Offset(0, 3), // changes position of shadow
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const CustomText(
//             text: "Posted: 24 hours ago", //${Jiffy(ride.postedDate).fromNow()}",
//             size: 15,
//             weight: FontWeight.bold,
//             color: Colors.blueGrey,
//           ),
//           Container(
//             color: Colors.grey,
//             height: 0.5,
//             margin: EdgeInsets.symmetric(vertical: 8),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   startEndItem(Icons.trip_origin, AutofillHints.name), //ride.startingAddress),
//                   SizedBox(height: 5),
//                   startEndItem(Icons.location_on, AutofillHints.name), //ride.endAddress),
//                 ],
//               ),
//               // CachedNetworkImage(
//               //   //imageUrl: ride.vehicleImg,
//               //   // fit: BoxFit.cover,
//               //   // repeat: ImageR,
//               //   // imageBuilder: (context, imageProvider) => Container(
//               //   //   width: 70.0,
//               //   //   height: 70.0,
//               //   //   decoration: BoxDecoration(
//               //   //     shape: BoxShape.circle,
//               //   //     image: DecorationImage(
//               //   //         image: imageProvider, fit: BoxFit.cover),
//               //   //   ),
//               //   // ),
//               //   progressIndicatorBuilder: (context, url, downloadProgress) =>
//               //       CircularProgressIndicator(
//               //         value: downloadProgress.progress,
//               //         strokeWidth: 2,
//               //       ),
//               //   // placeholder: (context, url) => CircularProgressIndicator(),
//               //   errorWidget: (context, url, error) => Icon(Icons.error),
//               // )
//             ],
//           ),
//           Container(
//             color: Colors.grey,
//             height: 0.5,
//             margin: EdgeInsets.symmetric(vertical: 8),
//           ),
//           Row(
//             // mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Icon(Icons.visibility_sharp),
//               CustomText(text: "23"),
//               Container(
//                 color: Colors.grey,
//                 width: 1,
//                 margin: EdgeInsets.symmetric(horizontal: 8),
//                 height: 20,
//               ),
//               Icon(Icons.outbond_sharp),
//               CustomText(text: "45"),
//               Spacer(),
//               const CustomText(
//                 text:
//                 "Start on: 2023/04/05", // ${Jiffy(ride.startDate).MMMd}, ${ride.time.format(context)}",
//                 size: 15,
//                 weight: FontWeight.bold,
//                 color: Colors.red,
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }
// Row startEndItem(IconData ic, String locationName) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.start,
//     children: [
//       Icon(ic),
//       SizedBox(width: 5),
//       Container(
//         alignment: Alignment.topLeft,
//         //width: Get.width / 1.9,
//         child: Text(
//           locationName,
//           overflow: TextOverflow.ellipsis,
//           maxLines: 1,
//           textAlign: TextAlign.justify,
//           // textScaleFactor: 1.2,
//           style: TextStyle(
//               decoration: TextDecoration.none,
//               fontSize: 18,
//               // fontWeight: FontWeight.,
//               color: Colors.black),
//         ),
//       ),
//     ],
//   );
// }
