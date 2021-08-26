import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip_kit/screen/home/organiser.dart';
import 'package:trip_kit/services/chat.dart';

class TravelList extends StatefulWidget {
  const TravelList({Key? key}) : super(key: key);

  @override
  _TravelListState createState() => _TravelListState();
}

class _TravelListState extends State<TravelList> {
  final Stream<QuerySnapshot> _agentList = FirebaseFirestore.instance.collection('tour agents').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _agentList,
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasError)
            print(snapshot.error.toString());

          if (snapshot.hasData) {
            print('snapshot had data');
            return Scaffold(
              body: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document){
                  Map<String,dynamic> data = document.data()! as Map<String,dynamic>;
                    return Card(
                      child: ListTile(
                        title: Text(data['name']),
                        subtitle: Text(data['state']),
                        onTap:(){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) => Chat(
                              name: data['name'],
                              recieverUid: document.id,
                              )
                            )
                          );
                        }
                      ),
                    );
                }).toList(),
              ),

                floatingActionButton: FloatingActionButton.extended(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) => Organiser())
                  );
                },
                    label: Text('Plan yourself'),
              ),
            );
          }
          else
            return Container(child: Text('no data to show'));
        }
      );
  }
}

