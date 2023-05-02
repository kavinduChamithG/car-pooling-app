import 'package:carpooling_app/authentication/car_info_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import '../splashScreen/splash_screen.dart';

class CarInfoScreen extends StatefulWidget
{
  const CarInfoScreen({Key? key}) : super(key: key);
  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen>
{
  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController = TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();

  List<String> carTypesList = ["uber-x", "uber-go", "bike"];
  String? selectedCarType;

  get driversRef => null;

  saveCarInfo()
  {
    Map driverCarInfoMap =
    {
      "car_color": carColorTextEditingController.text.trim(),
      "car_number": carNumberTextEditingController.text.trim(),
      "car_model": carModelTextEditingController.text.trim(),
      "type": selectedCarType,
    };

    DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
    driversRef.child(currentFirebaseUser!.uid).child("car_details").set(driverCarInfoMap);

    Fluttertoast.showToast(msg: "Car Details has been saved, Congratulations.");
    Navigator.push(context, MaterialPageRoute(builder: (c)=>const MySplashScreen()));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Info'),
        backgroundColor: Color.fromARGB(255, 219, 136, 12),
      ),
      backgroundColor: Color.fromARGB(255, 21, 18, 22),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Enter Your Vehicle Information',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w600,
                      fontSize: 30),
                )),
            const Divider(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                key: ValueKey("carModel"),
                controller: carModelTextEditingController,
                // validator: EmailFieldValidator.validate,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Car Model',
                   labelStyle: TextStyle(color: Colors.white), // set the label text color to white
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
                key: ValueKey("carNumber"),
                controller: carNumberTextEditingController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Car Number',
                   labelStyle: TextStyle(color: Colors.white), // set the label text color to white
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
                key: ValueKey("carColor"),
                controller: carColorTextEditingController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Car Color',
                   labelStyle: TextStyle(color: Colors.white), // set the label text color to white
                  focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 219, 136, 12),)),
                  filled: true, // Set filled to true
                  fillColor: Color.fromARGB(184, 74, 73, 71),
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
              child: DropdownButton(
                iconSize: 30,
                //icon: Icon(Icons.arrow_downward_rounded),
                dropdownColor: Colors.black54,
                hint: const Text(
                  "Car Type",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                value: selectedCarType,
                onChanged: (newValue) {
                  setState(() {
                    selectedCarType = newValue.toString();
                  });
                },
                icon: Icon(Icons.arrow_drop_down, color: Color.fromARGB(255, 255, 255, 255)),
                items: carTypesList.map((car) {
                  return DropdownMenuItem(
                    child: Text(
                      car,
                      style: const TextStyle(color: Colors.white),
                    ),
                    value: car,
                  );
                }).toList(),
              ),
            ),


            // Container(
            //   padding: const EdgeInsets.all(10),
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       color: Colors.grey,
            //       width: 1.0,
            //       style: BorderStyle.none,
            //     ),
            //   ),
            //   child: DropdownButton(
            //     dropdownColor: Colors.black54,
            //     hint: const Text(
            //       "Please Choose car Type",
            //       style: TextStyle(
            //         fontSize: 14.0,
            //         color: Colors.white,
            //       ),
            //     ),
            //     value: selectedCarType,
            //     onChanged: (newValue)
            //     {
            //       setState(() {
            //         selectedCarType = newValue.toString();
            //       });
            //     },
            //     items: carTypesList.map((car){
            //       return DropdownMenuItem(
            //         child: Text(
            //           car,
            //           style: const TextStyle(
            //             color: Colors.white
            //           ),
            //         ),
            //         value: car,
            //       );
            //     }).toList(),
            //
            //   ),
            // ),

SizedBox(height:20),
            Container(
              height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                  color: Color.fromARGB(255, 219, 136, 12),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                     ),
                    ],
                    ),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: ElevatedButton(
                key: ValueKey("submit"),
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Color.fromARGB(255, 219, 136, 12))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Create Account', textAlign: TextAlign.center),
                    SizedBox(width: 10), // Adding some space between the text and icon
                    IconTheme(
                      data: IconThemeData(size: 15.0, color: Color.fromARGB(255, 2, 2, 2)), // set the size of the icon
                      child: Icon(Icons.create_rounded),
                    ),
                  ],
                ),
                onPressed: ()
                {
                  if(carColorTextEditingController.text.isNotEmpty
                      && carNumberTextEditingController.text.isNotEmpty
                      && carModelTextEditingController.text.isNotEmpty
                      && selectedCarType != null
                  ){
                      saveCarInfo();
                  }
                  //Navigator.push(context, MaterialPageRoute(builder: (c)=> CarInfoScreen()));
                },
              ),
            ),


          ],
        ),
      ),
    );

  }

}


