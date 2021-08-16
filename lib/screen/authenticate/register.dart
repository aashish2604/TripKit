import 'package:flutter/material.dart';
import 'package:trip_kit/services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  String? _confirmPassword;
  String? _name;
  double? _phoneNumber;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('REGISTER',style: TextStyle(color: Colors.black),),
        elevation: 3,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10,30,10,0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Email'
                    ),
                    onChanged: (val) {
                      setState(() {
                        _email = val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Password'
                    ),
                    onChanged: (val) {
                      setState(() {
                        _password = val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Confirm Password'
                    ),
                    onChanged: (val) {
                      setState(() {
                        _confirmPassword = val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Name'
                    ),
                    onChanged: (val) {
                      setState(() {
                        _name = val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Contact Number'
                    ),
                    onChanged: (val) {
                      setState(() {
                        _phoneNumber = double.parse(val);
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(

                      ),
                      onPressed: (){
                        print(_email ?? 'null value in email');
                        print(_password ?? 'null value in password');
                        print(_phoneNumber ?? 'phone number is null');
                        print(_name ?? 'name is null');
                        AuthService().registerWithEmailAndPassword(_email!, _password!, _name!, _phoneNumber!);
                      },
                      child: Text('Proceed')
                  ),
                  SizedBox(height: 10),

                  ///Adding the OR with horizontal line on each side
                  Row(children: <Widget>[
                    Expanded(
                      child: new Container(
                          margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                          child: Divider(
                            color: Colors.black,
                            height: 50,
                          )),
                    ),

                    Text("Or Register using"),

                    Expanded(
                      child: new Container(
                          margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                          child: Divider(
                            color: Colors.black,
                            height: 50,
                          )),
                    ),
                  ]
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.email_outlined,color: Colors.white,),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))
                        ),
                        onPressed: (){
                          print('Login using gmail account');
                        },
                        label: Text('Gmail',style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton.icon(
                        icon: Icon(Icons.facebook_rounded,color: Colors.white,),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))
                        ),
                        onPressed: (){
                          print('Login using facebook account');
                        },
                        label: Text('Facebook',style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton.icon(
                        icon: Icon(Icons.map,color: Colors.white,),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))
                        ),
                        onPressed: (){
                          print('Login using twitter account');
                        },
                        label: Text('Twitter',style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  SizedBox(height: 60),
                  Text('Already registered? Login'),
                  SizedBox(height: 5),
                  ElevatedButton(
                      onPressed: () {
                        widget.toggleView();
                      },
                      child: Text('Sign In')
                  ),
                ],
              )

          ),

        ),
      ),
    );
  }
}
