import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SpotList extends StatefulWidget {
  final String name;
  final double lon,lat,radius;

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
  
  Future getApiData()async{
    var data =await http.get(Uri.parse("https://api.opentripmap.com/0.1/en/places/radius?radius=${widget.radius}&lon=${widget.lon}&lat=${widget.lat}&kinds=interesting_places&rate=3&format=json&apikey=5ae2e3f221c38a28845f05b644e948b7e92a371bc9622916ba1f0e95"));
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
        title: Text('Famous places in ${widget.name}'),
      ),
      body: apiData==null? Center(child: Text('Loading...'),): ListView.builder(
          itemCount: apiData!.length,
          itemBuilder: (BuildContext context, int index){
            return Card(
              child: ListTile(
                title: Text(apiData![index]['name']),
                subtitle: Text('Rating: ${apiData![index]['rate']}'),
              ),
            );

          }
      )
    );
  }
}
