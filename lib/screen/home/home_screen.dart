import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip_kit/screen/home/india_states.dart';
import 'package:trip_kit/screen/home/location.dart';
import 'package:trip_kit/screen/home/organiser.dart';
import 'package:trip_kit/screen/home/travel_agent_list.dart';
import 'package:trip_kit/screen/home/wishlist.dart';
import 'package:trip_kit/screen/navigation/navigation_drawer.dart';
import 'package:trip_kit/services/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: Text('Trip Kit'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red,Colors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Location',icon: Icon(Icons.location_on),),
              Tab(text: 'Wishlist',icon: Icon(Icons.face),),
              Tab(text: 'Tour Agents',icon: Icon(Icons.book),),
            ],
          ),
        ),
        body: TabBarView(
            children: [
              StatesIndia(),
              WishList(),
              TravelList(),
            ]
        )
      ),
    );
  }
}
