import 'package:flutter/material.dart';
import 'package:trip_kit/services/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Column(
          children: [
            Text('Home'),
            ElevatedButton(
                onPressed: (){
                  AuthService().signOut();
                },
                child: Text('sign out'))
          ],
        ),
      ),
    );
  }
}
