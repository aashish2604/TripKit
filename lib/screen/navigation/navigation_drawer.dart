import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_kit/services/auth.dart';
import 'package:trip_kit/services/database.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        String _name = snapshot.data.get('name');
        return Drawer(
          child: Material(
            color: Color.fromRGBO(45, 64, 184, 1),
            child: ListView(
              children: [
                SizedBox(height: height*0.01),

                //title
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                  child: Text('Trip Kit',style: TextStyle(fontSize: 25,color: Colors.white)),
                ),
                SizedBox(height: height*0.03),

                //Profile
                InkWell(
                  onTap: (){},
                  child:Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: width*0.1,
                        ),
                        SizedBox(width: width*0.04),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_name,style: TextStyle(fontSize:20 ,color: Colors.white)),
                            SizedBox(height: 5),
                            Text('${user.email}',style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height*0.01),

                //MyPlans
                ListTile(
                  leading: Icon(Icons.assignment,color: Colors.white),
                  title: Text('My plans',style: TextStyle(color: Colors.white),),
                  onTap: (){},
                ),

                //SignOut
                SizedBox(height: height*0.01),
                ListTile(
                  leading: Icon(Icons.power_settings_new,color: Colors.white),
                  title: Text('Sign Out',style: TextStyle(color: Colors.white),),
                  onTap: ()=> AuthService().signOut(),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
