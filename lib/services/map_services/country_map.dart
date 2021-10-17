import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLocation extends StatefulWidget {
  final double lat;
  final double lon;

  const MapLocation({Key? key,required this.lat,required this.lon}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red,Colors.orange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: GoogleMap(
            mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
              target: LatLng(widget.lat, widget.lon),
              zoom: 15,

          ))
      ),
    );
  }
}
