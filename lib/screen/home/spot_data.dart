import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trip_kit/services/database.dart';
import 'package:url_launcher/url_launcher.dart';

class SpotData extends StatefulWidget {

  final String xid;
  const SpotData({Key? key,required this.xid}) : super(key: key);

  @override
  _SpotDataState createState() => _SpotDataState();
}


class _SpotDataState extends State<SpotData> {

  Map? apiData;
  bool? isliked;

  Future getApiData()async{
    var data =await http.get(Uri.parse("https://api.opentripmap.com/0.1/en/places/xid/${widget.xid}?apikey=5ae2e3f221c38a28845f05b644e948b7e92a371bc9622916ba1f0e95"));
    setState(() {
      apiData = jsonDecode(data.body);
    });
  }

  Future isLiked()async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('wishlist');
    var doc =await collectionReference.doc('$uid-${widget.xid}').get();
    isliked= doc.exists;
  }

  void launchURL(String _url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

 @override
  void initState(){
   super.initState();
   getApiData();
   isLiked();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return apiData==null || isliked==null?Text('Loading..'): Scaffold(
      appBar: AppBar(
        title:Text('Location Details'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red,Colors.orange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(

          //Parent stack
          child: Stack(
            children: [
              Column(
                children: [

                  ///Container of the image
                  Container(
                    width: double.infinity,
                    height: height*0.5,
                    decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(apiData!['preview']['source']),fit: BoxFit.fill)),
                  ),

                  ///Container of the details
                  Container(
                    padding: EdgeInsets.fromLTRB(width*0.05, height*0.08, width*0.05, 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Address:'),
                            SizedBox(width: width*0.18),
                            apiData!['address']['suburb']==null? Expanded(child: Text('${apiData!['address']['city']}, ${apiData!['address']['state']}-${apiData!['address']['postcode']}.')) : Expanded(child: Text('${apiData!['address']['suburb']}, ${apiData!['address']['city']}, ${apiData!['address']['state']}-${apiData!['address']['postcode']}.')),
                          ],
                        ),
                        SizedBox(height: 0.025*height),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Description:',style: TextStyle(fontSize: 15),),
                            SizedBox(width: width*0.07),
                            Expanded(child: Text('${apiData!['wikipedia_extracts']['text']}',textAlign: TextAlign.end,))
                          ],
                        ),
                        SizedBox(height: height*0.03)
                      ],
                    ),
                  )
                ],
              ),

              ///Container of the title box (needs to be stacked above the column containing the pic and the details)
              Positioned(
                left: width*0.08,
                right: width*0.08,
                top: height*0.45,
                child: Container(
                  height: height*0.1,
                  padding: EdgeInsets.fromLTRB(width*0.05, width*0.02, width*0.05, 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.orange,
                    boxShadow: [BoxShadow(
                      color: Colors.black54,
                      blurRadius: 2.0,
                      spreadRadius: 1.0,
                      offset: Offset(2.0, 2.0),
                    )]
                  ),
                  child: Column(
                    children: [
                      Expanded(
                          child: Text(apiData!['name'],
                            style: TextStyle(color: Colors.white,fontSize: 25),overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )),
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                            child: FloatingActionButton(onPressed: (){},
                              backgroundColor: Colors.yellow,
                              child: Icon(Icons.location_on,color: Colors.redAccent,)),
                          ),
                          SizedBox(width: width*0.01),
                          Container(
                            margin: EdgeInsets.all(4),
                            height: 30,
                            child: OutlinedButton(
                              onPressed: (){launchURL(apiData!['wikipedia']);},
                              child: Text('Know more'),
                              style: OutlinedButton.styleFrom(
                                primary: Colors.yellow,
                                side: BorderSide(color: Colors.yellow,)
                              ),
                            ),
                          ),
                          SizedBox(width: width*0.18),
                          SizedBox(
                            height: 30,
                            child: IconButton(
                                onPressed: ()async{
                                  setState(() {
                                    if(isliked!){
                                      Database().wishListRemove(widget.xid);
                                      isliked=false;
                                    }
                                    else {
                                      Database().wishListAdd(apiData!['name'], widget.xid);
                                      isliked=true;
                                    }
                                  });

                                },
                                icon: isliked! ? Icon(Icons.favorite,color: Colors.red,): Icon(Icons.favorite_outline,color: Colors.yellow,)
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
