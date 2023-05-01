import 'package:carpooling_app/global/global.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationSystem{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future initializeCloudMessaging() async
  {
    //1.Terminated
    //when app is completely closed and opened directly from the push notification
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? remoteMessage)
    {
      if(remoteMessage != null)
      {
        print("This is remote message :: ");
        print(remoteMessage.data["rideRequestId"]);
        //Display ride request information - user information who request a ride
      }
    });

    //2.Foreground
    //when app is open and it receives a notification
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage)
    {
      print("This is remote message :: ");
      print(remoteMessage!.data["rideRequestId"]);
      //Display ride request information - user information who request a ride
    });

    //3.Background
    //when app is in background and opened directly from the push notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage)
    {
      print("This is remote message :: ");
      print(remoteMessage!.data["rideRequestId"]);

    });
  }

  Future generateAndGetToken() async
  {
    String? registrationToken = await messaging.getToken();
    print("FCM Registration Token: ");
    print(registrationToken);
    FirebaseDatabase.instance.ref()
        .child("drivers")
        .child(currentFirebaseUser!.uid)
        .child("token")
        .set(registrationToken);
    
    messaging.subscribeToTopic("allDrivers");
    messaging.subscribeToTopic("allUsers");
  }

}