import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_kit/screen/home/spot_data.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String _uid = _auth.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('wishlist').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Some error occured');
          if (snapshot.connectionState == ConnectionState.waiting)
            return Text('Loading..');
          return snapshot.data!.docs.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    if (_uid == document['uid']) {
                      return Card(
                        child: ListTile(
                          title: Text(document['name']),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SpotData(xid: document['xid'])));
                          },
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                )
              : const Center(
                  child: Text('Your wishlist is empty'),
                );
        });
  }
}
