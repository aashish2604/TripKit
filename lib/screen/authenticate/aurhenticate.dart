import 'package:flutter/material.dart';
import 'package:trip_kit/screen/authenticate/login.dart';
import 'package:trip_kit/screen/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {



    return Container(
      child: showSignIn? Login(toggleView: toggleView):Register(toggleView: toggleView),
    );
  }
}
