import 'package:flutter/material.dart';
import 'package:message_application/Screens/SplachScreen.dart';


import 'package:firebase_core/firebase_core.dart';

late Size mq;
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

// _initializeFirebase() async{
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
// }