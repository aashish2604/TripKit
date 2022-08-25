import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_kit/services/loading.dart';

class ViewPlans extends StatelessWidget {
  const ViewPlans({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    print(uid);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your planned trips'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.orange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FutureBuilder(
            future:
                FirebaseFirestore.instance.collection('plans').doc(uid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                    snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final response = snapshot.data!.data();
                if (response!.isEmpty) {
                  return const Center(
                    child: Text('Nothing found'),
                  );
                } else {
                  List data = response['plan_list'];
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Initial Location:  ${data[index]['initial location']}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'FInal Destination:  ${data[index]['destination']}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'No of Days:  ${(data[index]['no of days']).toString()}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Estimated Budget:  ${data[index]['estimated budget'].toString()}',
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loading();
              } else {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
            }),
      ),
    );
  }
}
