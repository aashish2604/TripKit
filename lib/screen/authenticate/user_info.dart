import 'package:flutter/material.dart';
import 'package:trip_kit/services/auth.dart';

class UserInfo extends StatefulWidget {
  final String email;
  final String password;
  const UserInfo({
    Key? key,
    required this.email,
    required this.password,

  }) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final _formKey = GlobalKey<FormState>();
  String? _name,error;
  double? _phoneNumber;
  String? date;
  String? _country = 'Choose your country';
  String? _state = 'Choose your state';
  final List<String> countries = ['India','France','USA','United Kingdom'];
  final List<String> states = ['Bihar','Delhi','UP','Punjab','Uttrakhand','Karnataka'];
  final gender = <String>['Male','Female','Other'];
  String? selectedValue;


  @override
  Widget build(BuildContext context) {

    Future pickDate(BuildContext context)async{

      final initialDate = DateTime.now();
      final newDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(DateTime.now().year-100),
          lastDate: DateTime(DateTime.now().year +100));
      if(newDate == null) {
        setState(() {
          date = 'Date of Birth';
        });
      } else {
        setState(() {
          date = '${newDate.day}/${newDate.month}/${newDate.year}';
        });
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10,50,10,0),
          child: Form(
            key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        print("image pressed");
                      },
                      child: CircleAvatar(
                        radius: 50,

                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Name'
                    ),
                    validator: (val) => val!.isEmpty? 'Please enter your name' : null,
                    onChanged: (val) {
                      setState(() {
                        _name = val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (val) => val!.length==10? null : 'Please enter a valid phone number',
                    decoration: InputDecoration(
                        hintText: 'Contact Number'
                    ),
                    onChanged: (val) {
                      setState(() {
                        _phoneNumber = double.parse(val);
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField(
                    validator: (val){
                      if(val == null)
                        return 'Please select your country';
                      else
                        return null;
                    },
                    hint: Text('Select your country'),
                      items: countries.map((country){
                        return DropdownMenuItem(
                            value: country,
                            child: Text('$country'),
                        );
                      }).toList(),
                    onChanged: (val){
                      setState(() {
                          _country = val.toString();
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField(
                    validator: (val) => (val==null)? 'Please select a state': null,
                    hint: Text('Select your state'),
                      items: states.map((state){
                        return DropdownMenuItem(
                            value: state,
                            child: Text(state),
                        );
                      }).toList(),
                    onChanged: (val){
                        setState(() {
                          _state = val.toString();
                        });
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Column(
                      children: gender.map((value) {
                        return RadioListTile(
                            value: value,
                            groupValue: selectedValue,
                            title: Text(value),
                            onChanged: (value){
                              setState(() {
                                selectedValue = value.toString();
                              });
                            });
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    child: TextButton.icon(
                        icon: Icon(Icons.calendar_today_rounded,color: Colors.black,),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          alignment: Alignment.bottomLeft,
                        ),
                        onPressed: (){
                          pickDate(context);
                        },
                        label: Text(date ?? 'Date of Birth',
                          style: TextStyle(color: Colors.black),
                        )
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                        onPressed: ()async{
                          if (_formKey.currentState!.validate()) {
                            if (date!='Date of Birth' && selectedValue!=null) {
                              await AuthService().registerWithEmailAndPassword(widget.email, widget.password, _name!, _phoneNumber!);
                              Navigator.pop(context,true);
                            }
                            else
                              error = 'Please enter information for all the fields';
                          }
                        },
                        child: Text('Register')
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(error ?? '',style: TextStyle(color: Colors.red,fontSize: 15)),

                ],
              ),
          ),
        ),
      ),
    );
  }
}
