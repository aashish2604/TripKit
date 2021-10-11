import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trip_kit/screen/home/spots_list.dart';

class StatesIndia extends StatefulWidget {
  const StatesIndia({Key? key}) : super(key: key);

  @override
  _StatesIndiaState createState() => _StatesIndiaState();
}

class _StatesIndiaState extends State<StatesIndia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString("assets/indian-states-coordinates.json"),
            builder: (context,snapshot){
              var data = jsonDecode(snapshot.data.toString());
              return data==null?Text('Loading'): ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context,int index){
                  return Card(
                    child: ListTile(
                      title: Text(data[index]['name']),
                      subtitle: Text(data[index]['abb']),
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context)=> SpotList(
                                name: data[index]['name'],
                                lon: double.parse(data[index]['lon']),
                                lat: double.parse(data[index]['lat']),
                                radius: double.parse(data[index]['size'])))
                        );
                      },
                    ),
                  );
                });
            },
        ),
    );
  }
}
