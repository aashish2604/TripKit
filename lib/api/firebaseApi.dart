import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi{

  static Future? uploadMessage(String senderUid,String recieverUid,String message)async{

    try {
      CollectionReference messages = FirebaseFirestore.instance.collection('chats');
      await messages.doc('$senderUid-$recieverUid').collection('messages').add({
        'sender uid': senderUid,
        'receiver uid': recieverUid,
        'message': message,
        'sending time': DateTime.now(),
      });
    } on Exception catch (e) {
      print(e.toString());
    }

  }



}