import 'package:flutter/material.dart';
 
class ScheduleTilesPage extends StatefulWidget {
  const ScheduleTilesPage({super.key});

  @override
  State<ScheduleTilesPage> createState() => _ScheduleTilesPageState();
}

class _ScheduleTilesPageState extends State<ScheduleTilesPage> {
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
        /** Card Widget **/
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
                        'Star Location : Rathnapura',
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
//imported google's material design library
