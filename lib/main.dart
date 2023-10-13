//import 'dart:js';

//import 'dart:js';

import 'package:carpooling_app/blocs/payment/payment_bloc.dart';
import 'package:carpooling_app/global/stripe_key.dart';
import 'package:carpooling_app/infoHandler/app_info.dart';
import 'package:carpooling_app/splashScreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings();
  await Firebase.initializeApp();

  // runApp(MyApp(
  //     child: MaterialApp(
  //               title: 'Flutter Demo',
  //               theme: ThemeData(
  //                 primarySwatch: Colors.blue,
  //               ),
  //               home: const MySplashScreen(),
  //               debugShowCheckedModeBanner: false,
  //             ),
  // ));
  runApp(
    MyApp(
      child: ChangeNotifierProvider(
        create: (context) => AppInfoc(),
          child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MySplashScreen(),
          debugShowCheckedModeBanner: false,
        ),
        )
        
      )
  );
}

class MyApp extends StatefulWidget
{
  final Widget? child;

  MyApp({this.child});

  static void restartApp(BuildContext context)
  {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
{
  Key key = UniqueKey();
  void restartApp()
  {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PaymentBloc(),
        child: KeyedSubtree(
          key: key,
          child: widget.child!,
        )
    );
    // return KeyedSubtree(
    //   key: key,
    //   child: widget.child!,
    //);
  }
}

