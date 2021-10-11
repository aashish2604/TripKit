import 'package:flutter/material.dart';
import 'package:trip_kit/screen/authenticate/user_info.dart';
import 'package:trip_kit/services/auth.dart';
import 'package:trip_kit/services/loading.dart';

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
  bool loading = false;
  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return loading? Loading(): Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height*1,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/auth.jpg'),fit: BoxFit.fill)),
          child: Padding(
            padding:  EdgeInsets.fromLTRB(width*0.05,30,width*0.05,0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: height*0.32),
                    Text('Register',style: TextStyle(fontSize: 30,color: Colors.black),),
                    SizedBox(height: height*0.01),
                    TextFormField(
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white,fontSize: 19),
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2)),
                          hintStyle: TextStyle(fontSize: 19, color: Colors.white60),
                          hintText: 'Email'
                      ),
                      onChanged: (val) {
                        setState(() {
                          _email = val;
                        });
                      },
                    ),
                    SizedBox(height: height*0.02),
                    TextFormField(
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white,fontSize: 19),
                      obscureText: _isHidden,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2)),
                          hintStyle: TextStyle(fontSize: 19, color: Colors.white60),
                          hintText: 'Password',
                        suffix: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(
                            _isHidden
                                ? Icons.visibility
                                : Icons.visibility_off,color: Colors.grey,
                          ),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _password = val;
                        });
                      },
                    ),
                    SizedBox(height: height*0.02),
                    TextFormField(
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white,fontSize: 19),
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2)),
                          hintStyle: TextStyle(fontSize: 19, color: Colors.white60),
                          hintText: 'Confirm Password'
                      ),
                      onChanged: (val) {
                        setState(() {
                          _confirmPassword = val;
                        });
                      },
                    ),
                    SizedBox(height: height*0.02),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(

                        ),
                        onPressed: ()async{
                          loading = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) => UserInfo(
                                email: _email!,
                                password: _password!,
                              ),
                              )
                          );
                          if(loading == true)
                            setState(() {
                              loading = true;
                            });
                        },
                        child: Text('Proceed')
                    ),
                    SizedBox(height: height*0.01),

                    ///Adding the OR with horizontal line on each side
                    Row(children: <Widget>[
                      Expanded(
                        child: new Container(
                            margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                            child: Divider(
                              color: Colors.white70,
                              height: 50,
                            )),
                      ),

                      Text("Or Register using",style: TextStyle( color: Colors.white70)),

                      Expanded(
                        child: new Container(
                            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                            child: Divider(
                              color: Colors.white70,
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
                    SizedBox(height: height*0.03),
                    Text('Already registered? Login',style: TextStyle( color: Colors.white70)),
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
      ),
    );
  }
}
