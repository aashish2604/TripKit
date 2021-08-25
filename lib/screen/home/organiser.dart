import 'package:flutter/material.dart';
import 'package:trip_kit/screen/home/travel_agent_list.dart';
import 'package:trip_kit/services/database.dart';

class Organiser extends StatefulWidget {
  const Organiser({Key? key}) : super(key: key);

  @override
  _OrganiserState createState() => _OrganiserState();
}

class _OrganiserState extends State<Organiser> {
  final _formKey = GlobalKey<FormState>();
  String? _destination,_initialLocation;
  double? _days,_budget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Plan your tour',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontFamily: "DancingScript",fontSize: 30),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10,20,10,0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Destination'
                    ),
                    validator: (val) => val!.isEmpty? 'Please enter a location' : null,
                    onChanged: (val){
                      setState(() {
                        _destination = val;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Initial location(city/state/country)'
                    ),
                    validator: (val) => val!.isEmpty? 'Please enter a location' : null,
                    onChanged: (val){
                      setState(() {
                        _initialLocation = val;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'No of days'
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if((double.tryParse(val!) != null) && val.isNotEmpty)
                        return null;
                      else
                        return 'Please make a valid numeric entry';
                    },
                    onChanged: (val){
                      setState(() {
                        _days = double.parse(val);
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Estimated Budget'
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if((double.tryParse(val!) != null) && val.isNotEmpty)
                        return null;
                      else
                        return 'Please make a valid numeric entry';
                    },
                    onChanged: (val){
                      setState(() {
                        _budget = double.parse(val);
                      });
                    },
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(onPressed: (){
                    if(_formKey.currentState!.validate()){
                      Database().createPlannerData(_destination!, _initialLocation!, _days!, _budget!);
                    }
                    else
                      print('Invalid entry');
                  },
                      child: Text('Save')),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
