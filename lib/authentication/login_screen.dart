import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:carpooling_app/authentication/signup_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import '../splashScreen/splash_screen.dart';
import '../widgets/progress_dialog.dart';

final globalScaffoldKey = GlobalKey<ScaffoldState>();

class LoginScreen extends StatefulWidget
{

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  validateForm()
  {

    if(!emailController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email address is not valid.");
    }

    else if(passwordController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Password is required");
    }
    else
    {
      loginDriverNow();

    }
  }

  loginDriverNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Processing, Please Wait..",);
        }
    );

    final User? firebaseUser = (
        await fAuth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if(firebaseUser != null)
    {
      DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(firebaseUser.uid).once().then((driverKey)
      {
        final snap = driverKey.snapshot;
        if(snap.value != null)
        {
          currentFirebaseUser = firebaseUser;
          Fluttertoast.showToast(msg: "Login Successful.");
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        }
        else
        {
          Fluttertoast.showToast(msg: "No record exist with this email.");
          fAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        }
      });

      // currentFirebaseUser = firebaseUser;
      // Fluttertoast.showToast(msg: "Login Successful");
      // Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));

    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occured during Signin");

    }
  }


  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalScaffoldKey,
        appBar: AppBar(
          title: const Text('Log-In'),
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
                      'Log-In',
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
                    key: ValueKey("userName"),
                    controller: emailController,
                    style: TextStyle(color: Colors.white), 
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      labelStyle: TextStyle(color: Colors.white), // set the label text color to white
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 219, 136, 12), )),
                      filled: true, // Set filled to true
                      fillColor: Color.fromARGB(184, 74, 73, 71),
                    ),
                    
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    key: ValueKey("password"),
                    obscureText: true,
                    controller: passwordController,
                    style: TextStyle(color: Colors.white), 
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white), // set the label text color to white
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 219, 136, 12), )),
                      filled: true, // Set filled to true
                  fillColor: Color.fromARGB(184, 74, 73, 71),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  style: TextButton.styleFrom(foregroundColor: Color.fromARGB(221, 244, 242, 242)),
                  child: const Text('Forgot Password?'),
                ),

                
                  // Set the width of the button
                  Container(
                    width: double.infinity,
                    height: 50,
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
                  
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                        key: ValueKey("login"),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                               RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                              elevation: MaterialStateProperty.all<double>(0),
                            //backgroundColor:MaterialStateProperty.all<Color>(Color.fromARGB(255, 250, 192, 3)),
                            //foregroundColor: MaterialStateProperty.all<Color>(Colors.black)), 
                        ),
                        child: const Text('Login',style:( TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 18))),
                        onPressed: () {
                          validateForm();
                        })),
                // ignore: avoid_unnecessary_containers
                Container(
                    child: Row(
                      children: <Widget>[
                        const Text("Does not have account?",
                        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 243, 180, 33)),
                          ),
                          child: const Text(
                            'Create Account',
                            style: TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                            ),
                            );
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],
            )));
  }
}
