
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_place/google_place.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart';

class CountryMap extends StatefulWidget {
  const CountryMap({Key? key}) : super(key: key);

  @override
  _CountryMapState createState() => _CountryMapState();
}

class _CountryMapState extends State<CountryMap> {
  String query = 'India';
  List? searchResult;
  GoogleMapController? mapController;

  //function which implements the text search method of google places api
  void _placeSearch()async{
    var googlePlace = GooglePlace("AIzaSyBKWfoeoUdf5bI1TtHm8b8pxQcdjgn__aI");
    var result = await googlePlace.search.getTextSearch("restaurants in Sydney");
    Response response = await get(Uri.parse('https://maps.googleapis.com/maps/api/place/textsearch/json?query=restaurants%20in%20Sydney&key=AIzaSyBKWfoeoUdf5bI1TtHm8b8pxQcdjgn__aI'));
    Map data = jsonDecode(response.body);
    print(data);
  }

  //function to implement the permission handler package to ask for the permission during runtime
  void checkPermission()async{
    await Permission.location.request();
    final _permission = await Permission.location.status.isDenied;
    if(_permission)
      print('Permission is denied');
    else
      _placeSearch();
  }

  @override
  void initState(){
    super.initState();
    checkPermission();
  }

  //function to initialize the map controller in the onMapCreated of the google maps
  void onMapCreated(controller){
    setState(() {
      mapController = controller;
    });
  }

  //function to perform reverse geoCoding
  void geoSearch()async{
    await locationFromAddress(query).then((value){
      mapController!.animateCamera(CameraUpdate.newLatLng(LatLng(value[0].latitude, value[0].longitude)));
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('India'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.transparent),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: IconButton(
                      onPressed: geoSearch,
                      icon: Icon(Icons.search)
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onChanged: (val){
                  setState(() {
                    query = val;
                  });
                },
              ),
            ),
            Container(
              height: h *0.798,
              child: GoogleMap(
                onMapCreated: onMapCreated,
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(20.5937, 78.9629),
                    zoom: 7
                )
              )
            )
          ],
        ),
      )
    );


  }
}
