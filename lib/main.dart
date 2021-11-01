import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trip_kit/wrapper.dart';
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        errorColor: Colors.yellow,
        accentColor: Colors.white,
        splashColor: Colors.white38,
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.orange),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(primary: Colors.orange)),
      ),
      home: Wrapper(),
    );
  }
}