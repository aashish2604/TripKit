import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database{
  final CollectionReference collectionReference= FirebaseFirestore.instance.collection('users');
  final CollectionReference plannerData = FirebaseFirestore.instance.collection('plans');
  final CollectionReference wishList = FirebaseFirestore.instance.collection('wishlist');
  final FirebaseAuth auth = FirebaseAuth.instance;

  // making database for newly registered users
  Future? createInitialData(double contactNumber,String country,String dob,String gender,String name,String state,String image)async{

    User? user = auth.currentUser;
    String uid = user!.uid;
      return await collectionReference.doc(uid).set({
        'contact number': contactNumber,
        'country': country,
        'dob': dob,
        'gender': gender,
        'name': name,
        'state': state,
        'image': image,
      });
  }

  // updating trip plan database
  Future? createPlannerData(String destination,String initialLocation,double days,double budget)async{

    User? user = auth.currentUser;
    String uid = user!.uid;
    return await plannerData.doc(uid).set({
      'destination': destination,
      'initial location': initialLocation,
      'no of days': days,
      'estimated budget': budget,
    });
  }

 Future? wishListAdd(String name,String xid)async{
    User? user = auth.currentUser;
    String uid = user!.uid;
    return await wishList.doc('$uid-$xid').set({
      'name': name,
      'uid': uid,
      'xid': xid,
    });
 }

 Future? wishListRemove(String xid)async{
    User? user = auth.currentUser;
    String uid = user!.uid;
    return await wishList.doc('$uid-$xid').delete();
 }



  // delete data from database


}