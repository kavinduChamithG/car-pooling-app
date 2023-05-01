import 'package:flutter/material.dart';
import 'package:carpooling_app/authentication/signup_screen.dart';

final globalScaffoldKey = GlobalKey<ScaffoldState>();

class LoginScreen extends StatefulWidget
{

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
          title: const Text('Loging'),
          backgroundColor: Colors.orange, 
        ),
         backgroundColor: Color.fromARGB(255, 0, 0, 0), 
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
                    
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      labelStyle: TextStyle(color: Colors.white), // set the label text color to white
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                      filled: true, // Set filled to true
                      fillColor: Color.fromARGB(255, 215, 177, 3),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    key: ValueKey("password"),
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white), // set the label text color to white
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                      filled: true, // Set filled to true
                  fillColor: Color.fromARGB(255, 215, 177, 3),
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
                    color: Colors.orange,
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
                        child: const Text('Login',style: TextStyle(color: Colors.black)),
                        onPressed: () {
                          //todo
                        })),
                // ignore: avoid_unnecessary_containers
                Container(
                    child: Row(
                      children: <Widget>[
                        const Text("Does not have account?",
                        style: TextStyle(color: Colors.yellow),),
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
