import 'package:carpooling_app/authentication/car_info_screen.dart';
import 'package:carpooling_app/global/global.dart';
import 'package:carpooling_app/widgets/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:carpooling_app/authentication/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget
{
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
{
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController = TextEditingController();

  bool _obscureTextpassword = true;
  bool _obscureTextconfirmpassword = true;



  RegExp uppercaseRegex =  RegExp(r'[A-Z]');
  RegExp lowercaseRegex =  RegExp(r'[a-z]');
  RegExp symbolRegex =  RegExp(r'[@#\$%\^&\*()\+_\:;\?/\;.\,"-]');

  validateForm()
  {
    if(nameTextEditingController.text.length < 3)
    {
      Fluttertoast.showToast(msg: "name must be at least 5 characters.");
    }
    else if(!emailTextEditingController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email address is not valid.");
    }
    else if(passwordTextEditingController.text.length < 6)
    {
      Fluttertoast.showToast(msg: "Password must be at least 6 characters.");
    }
    else if(!uppercaseRegex.hasMatch(passwordTextEditingController.text)) {
    Fluttertoast.showToast(msg: "Password must contain at least one uppercase letter.");
    }
    else if(!lowercaseRegex.hasMatch(passwordTextEditingController.text)) {
    Fluttertoast.showToast(msg: "Password must contain at least one lowercase letter.");
    }
    else if(!symbolRegex.hasMatch(passwordTextEditingController.text)) {
    Fluttertoast.showToast(msg: "Password must contain at least one special character.");
    }
    else if(passwordTextEditingController.text !=confirmPasswordTextEditingController.text)
    {
      Fluttertoast.showToast(msg: "Confirm Password is not equal to the password entered.");
    }
    else if(phoneTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Phone Number is Required");
    }
    else if(phoneTextEditingController.text.length != 10)
    {
      Fluttertoast.showToast(msg: "Enter a valid phone number");
    }
    else
    {
      saveDriverInfoNow();
    }
  }

  saveDriverInfoNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Processing, Please Wait..",);
        }
    );



    // final User firebaseUser = (
    //   await fAuth.createUserWithEmailAndPassword(
    //       email: emailTextEditingController.text.trim(),
    //       password: passwordTextEditingController.text.trim(),
    //   ).catchError((msg)
    // );

    final User? firebaseUser = (
        await fAuth.createUserWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if(firebaseUser != null)
    {
      Map driverMap =
      {
        "id": firebaseUser.uid,
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };

      DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(firebaseUser.uid).set(driverMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been created");
      Navigator.push(context, MaterialPageRoute(builder: (c)=> CarInfoScreen()));

    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been created.");

    }

  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign-Up'),
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
                  'Sign-Up',
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
                key: ValueKey("emailID"),
                controller: emailTextEditingController,
                style: TextStyle(color: Colors.white), 
                keyboardType: TextInputType.emailAddress,
                // validator: EmailFieldValidator.validate,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email ID',
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
                key: ValueKey("userName"),
                controller: nameTextEditingController,
                style: TextStyle(color: Colors.white), 
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
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
              key: ValueKey("password"),
              obscureText: _obscureTextpassword,
              controller: passwordTextEditingController,
              style: TextStyle(color: Colors.white), 
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white), // set the label text color to white
                focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 219, 136, 12),)),
                filled: true, // Set filled to true
                fillColor: Color.fromARGB(184, 74, 73, 71),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureTextpassword = !_obscureTextpassword;
                    });
                  },
                  child: Icon(
                    _obscureTextpassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),


          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              key: ValueKey("confirmPassword"),
              obscureText: _obscureTextconfirmpassword,
              controller: confirmPasswordTextEditingController,
              style: TextStyle(color: Colors.white), 
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Confirm Password',
                labelStyle: TextStyle(color: Colors.white), // set the label text color to white
                focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 219, 136, 12),)),
                filled: true, // Set filled to true
                fillColor: Color.fromARGB(184, 74, 73, 71),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureTextconfirmpassword = !_obscureTextconfirmpassword;
                    });
                  },
                  child: Icon(
                    _obscureTextconfirmpassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                key: ValueKey("number"),
                controller: phoneTextEditingController,
                style: TextStyle(color: Colors.white), 
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: Colors.white), // set the label text color to white
                  focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 219, 136, 12),)),
                  filled: true, // Set filled to true
                  fillColor: Color.fromARGB(184, 74, 73, 71),
                ),
              ),
            ),
SizedBox(height:10),
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
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: ElevatedButton(
                    key: ValueKey("submit"),
                    //style: ButtonStyle(
                    //backgroundColor:MaterialStateProperty.all<Color>(Color.fromRGBO(255, 152, 0, 1))),
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
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Next', textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
                        SizedBox(width: 5), // Adding some space between the text and icon
                        Icon(Icons.navigate_next_rounded),
                      ],
                    ),
                    onPressed: ()
                    {
                      validateForm();
                      //Navigator.push(context, MaterialPageRoute(builder: (c)=> CarInfoScreen()));
                    },

      // backgroundColor: Colors.black,
      //   body: SingleChildScrollView(
      //     child: Padding(
      //       padding: const EdgeInsets.all(16.0),
      //       child: Column(
      //         children: [
      //
      //           const SizedBox(height: 100,),
      //
      //           Padding(
      //             padding: const EdgeInsets.all(5.0),
      //             child: Image.asset("images/logosmallimage.png"),
      //           ),
      //       const SizedBox(height: 10,),
      //       const Text(
      //         "Register as a Driver",
      //         style: TextStyle(
      //           fontSize: 26,
      //           color: Colors.grey,
      //           fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //
      //           TextField(
      //             controller: nameTextEditingController,
      //             style: const TextStyle(
      //               color: Colors.grey
      //             ),
      //             decoration: const InputDecoration(
      //               labelText: "Name",
      //               hintText: "Name",
      //               enabledBorder: UnderlineInputBorder(
      //                 borderSide: BorderSide(color: Colors.grey),
      //               ),
      //                 focusedBorder: UnderlineInputBorder(
      //                   borderSide: BorderSide(color: Colors.grey),
      //                 ),
      //               hintStyle: TextStyle(
      //                 color: Colors.grey,
      //                 fontSize: 10,
      //               ),
      //               labelStyle: TextStyle(
      //                 color: Colors.grey,
      //                 fontSize: 14,
      //               ),
      //             ),
      //           ),
      //
      //               TextField(
      //                 controller: emailTextEditingController,
      //                 keyboardType: TextInputType.emailAddress,
      //                 style: const TextStyle(
      //                   color: Colors.grey
      //                 ),
      //                 decoration: const InputDecoration(
      //                   labelText: "Email",
      //                   hintText: "Email",
      //                   enabledBorder: UnderlineInputBorder(
      //                     borderSide: BorderSide(color: Colors.grey),
      //                   ),
      //                   focusedBorder: UnderlineInputBorder(
      //                     borderSide: BorderSide(color: Colors.grey),
      //                   ),
      //                   hintStyle: TextStyle(
      //                     color: Colors.grey,
      //                     fontSize: 10,
      //                   ),
      //                   labelStyle: TextStyle(
      //                     color: Colors.grey,
      //                     fontSize: 14,
      //                   ),
      //               ),
      //           ),
      //               TextField(
      //                 controller: phoneTextEditingController,
      //                 keyboardType: TextInputType.phone,
      //                 style: const TextStyle(
      //                   color: Colors.grey
      //                 ),
      //                 decoration: const InputDecoration(
      //                   labelText: "Phone",
      //                   hintText: "Phone",
      //                 enabledBorder: UnderlineInputBorder(
      //                   borderSide: BorderSide(color: Colors.grey),
      //                 ),
      //                 focusedBorder: UnderlineInputBorder(
      //                   borderSide: BorderSide(color: Colors.grey),
      //                 ),
      //                 hintStyle: TextStyle(
      //                   color: Colors.grey,
      //                   fontSize: 10,
      //                 ),
      //                 labelStyle: TextStyle(
      //                   color: Colors.grey,
      //                   fontSize: 14,
      //                 ),
      //             ),
      //          ),
      //                 TextField(
      //                   controller: passwordTextEditingController,
      //                   keyboardType: TextInputType.text,
      //                   obscureText: true,
      //                   style: const TextStyle(
      //                     color: Colors.grey
      //                   ),
      //                   decoration: const InputDecoration(
      //                     labelText: "Password",
      //                     hintText: "Password",
      //                   enabledBorder: UnderlineInputBorder(
      //                     borderSide: BorderSide(color: Colors.grey),
      //                   ),
      //                   focusedBorder: UnderlineInputBorder(
      //                     borderSide: BorderSide(color: Colors.grey),
      //                   ),
      //                   hintStyle: TextStyle(
      //                     color: Colors.grey,
      //                     fontSize: 10,
      //                   ),
      //                   labelStyle: TextStyle(
      //                     color: Colors.grey,
      //                     fontSize: 14,
      //                   ),
      //               ),
      //           ),
      //               const SizedBox(height: 20,),

                    // ElevatedButton(
                    //   onPressed: ()
                    //   {
                    //     //todo
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     primary: Colors.lightGreenAccent,
                    //   ),
                    //   child: const Text(
                    //     "Create Account",
                    //     style: TextStyle(
                    //       color: Colors.black54,
                    //       fontSize: 18
                    //     ),
                    //   ),
                    // ),
              // ],




                  ),
                ),

            SizedBox(height:10),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  GestureDetector(
                    //onTap: () => AuthService().signInWithGoogle(),
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('images/google.png'),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 25),

                  // apple button
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('images/facebook.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),


            Container(
                child: Row(
                  children: <Widget>[

                    const Text("Already have account?",
                     style: TextStyle(color: Colors.white),),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 243, 180, 33)),
                      ),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))

          ],
        ),
      ),
    );

  }

}
