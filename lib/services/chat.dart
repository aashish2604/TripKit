import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip_kit/api/firebaseApi.dart';

class Chat extends StatefulWidget {
  final String name;

  const Chat({Key? key,required this.name})


      : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  String? message;
  final _controller = TextEditingController();

  void sendMessage()async{
    FocusScope.of(context).unfocus();
    //await FirebaseApi.uploadMessage(uid, message!);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.name}'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300]
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                    labelText: 'Type your message here',
                  ),
                  onChanged: (val){
                    setState(() {
                      message = val;
                    });
                  },
                ),
              ),
             SizedBox(width: 8),
             SizedBox(
               height: 50,
               child: FloatingActionButton(onPressed: (){
                  if(message!=null)
                    sendMessage();
                  else
                    print('Message body is empty');
               },
                  child: Icon(Icons.send),),
             )
            ],
          ),
        ),
      )

    );
  }
}
