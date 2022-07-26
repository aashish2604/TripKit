import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trip_kit/screen/home/spot_data.dart';
import 'package:trip_kit/secrets/keys.dart';
import 'package:trip_kit/services/loading.dart';

class SpotList extends StatefulWidget {
  final String name;
  final double lon, lat, radius;

  const SpotList({
    Key? key,
    required this.name,
    required this.lon,
    required this.lat,
    required this.radius,
  }) : super(key: key);

  @override
  _SpotListState createState() => _SpotListState();
}

class _SpotListState extends State<SpotList> {
  List? apiData;

  Future getApiData() async {
    var data = await http.get(Uri.parse(
        "https://api.opentripmap.com/0.1/en/places/radius?radius=${widget.radius}&lon=${widget.lon}&lat=${widget.lat}&kinds=interesting_places&rate=3&format=json&apikey=$kOpenTripMapApiKey"));
    setState(() {
      apiData = jsonDecode(data.body);
    });
  }

  @override
  void initState() {
    super.initState();
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Text('Famous places in ${widget.name}'),
        ),
        body: apiData == null
            ? Loading()
            : ListView.builder(
                itemCount: apiData!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text(apiData![index]['name']),
                      subtitle: Text('Rating: ${apiData![index]['rate']}'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SpotData(xid: apiData![index]['xid'])));
                      },
                    ),
                  );
                }));
  }
}
