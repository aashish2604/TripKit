import 'package:flutter/material.dart';
import 'package:trip_kit/model/countryList_model.dart';
import 'package:trip_kit/services/countryList_api.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<CountryListModel>>(
        future: CountryListApi.getCountryApi(context),
        builder: (context,snapshot){
          final countries = snapshot.data;
          if(snapshot.connectionState == ConnectionState.waiting)
            return(Center(child: CircularProgressIndicator(),));
          else if(snapshot.hasError){
            print(snapshot.error);
            return(Center(child: Text('Some error occurred'),));
          }
          else
            return buildCountryList(countries!);

        },

      ),
    );
  }

  Widget buildCountryList(List<CountryListModel> countries) => ListView.builder(
      itemCount: countries.length,
      itemBuilder: (context,index){
        final country = countries[index];
        return Card(
          child: ListTile(
            title: Text(country.name),
            subtitle: Text('country code: ${country.code}'),
          ),
        );
      }
  );

}
