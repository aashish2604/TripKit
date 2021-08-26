

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  final String senderUid,recieverUid;
  
  const MessagePage({Key? key,required this.recieverUid,required this.senderUid})
  
      : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  
  final chatMessages = FirebaseFirestore.instance.collection('chats');
  String _currentUid = FirebaseAuth.instance.currentUser!.uid;
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: chatMessages.doc('${widget.senderUid}-${widget.recieverUid}').collection('messages').orderBy('sending time',descending: true).snapshots(),
      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
        return snapshot.hasData? ListView(
          reverse: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document){
            Map<String,dynamic> data= document.data() as Map<String,dynamic>;
            bool isMe = (_currentUid==data['sender uid']?true:false);
            return Row(
              mainAxisAlignment: isMe? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.all(16),
                  constraints: BoxConstraints(maxWidth: 200),
                  decoration: BoxDecoration(
                    borderRadius: isMe
                    ? BorderRadius.only(
                      topLeft: Radius.circular(30), topRight: Radius.circular(30),bottomLeft: Radius.circular(30))
                    : BorderRadius.only(
                        topLeft: Radius.circular(30), topRight: Radius.circular(30),bottomRight: Radius.circular(30)),
                    color: isMe? Colors.blue: Colors.red,
                  ),
                  child: Text(data['message']),
                )
              ],
            );
          }).toList(),
        ) : Center(child: Text('Say Hi..'));
      }
    );
  }
}
