import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip_kit/model/countryList_model.dart';
import 'package:trip_kit/api/countryList_api.dart';
import 'package:trip_kit/services/map_services/country_map.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  String? query;
  late List<CountryListModel>? countries;

  @override
  void initState() {
    super.initState();
    this.initialize();
  }

  void initialize()async{
    countries =await CountryListApi.getCountryApi(context);
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: FutureBuilder<List<CountryListModel>>(
        future: CountryListApi.getCountryApi(context),
        builder: (context,snapshot){
          countries = snapshot.data;
          if(snapshot.connectionState == ConnectionState.waiting)
            return(Center(child: CircularProgressIndicator(),));
          else if(snapshot.hasError){
            print(snapshot.error);
            return(Center(child: Text('Some error occurred'),));
          }
          else{

            //ui of the page
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search..',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                    onChanged: (value){
                      query = value;
                      search(query!);
                    }
                  ),
                ),
                Expanded(child: buildCountryList(countries!)),
              ],
            );
          }
        },
      ),
    );
  }

  //for getting the list of countries
  Widget buildCountryList(List<CountryListModel> countries) => ListView.builder(
      itemCount: countries.length,
      itemBuilder: (context,index){
        final country = countries[index];
        return Card(
          child: ListTile(
            title: Text(country.name),
            subtitle: Text('country code: ${country.code}'),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) => CountryMap())
              );
            },
          ),
        );
      }
  );

  //function which performs search
  void search(String query){
    final _nation = countries!.where((element) {
      final nationLower = element.name.toLowerCase();
      final queryLower = query.toLowerCase();

      return nationLower.contains(queryLower);
    }).toList();

    setState(() {
      this.countries = _nation;
      this.query = query;
    });

  }

}
