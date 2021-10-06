import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  _WishListState createState() => _WishListState();
}

bool noWishList = true;

class _WishListState extends State<WishList> {

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String _uid = _auth.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('wishlist').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError)
            return Text('Some error occured');
          if(snapshot.connectionState == ConnectionState.waiting)
            return Text('Loading..');
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
              DocumentSnapshot document = snapshot.data!.docs[index];
              if (_uid==document['uid']) {
                return Card(
                  child: ListTile(
                    title: Text(document['name']),
                  ),
                );
              }
              else
                return Text('Nothing in the wishlist');
            },

          );
        }
    );
  }
}
