import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLocation extends StatefulWidget {
  final double lat;
  final double lon;
  final String spotName;

  const MapLocation({Key? key,required this.lat,required this.lon,required this.spotName}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapLocation> {
  Set<Marker> _markers={};

  void onMapCreated(GoogleMapController controller){
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(widget.lat, widget.lon),
          infoWindow: InfoWindow(
            title: widget.spotName,
            snippet: 'Tourist Spot'
          )

        )
      );
    });
  }

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
            onMapCreated: onMapCreated,
            markers: _markers,
            mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
              target: LatLng(widget.lat, widget.lon),
              zoom: 15,

          ))
      ),
    );
  }
}
