import 'dart:convert';

import 'package:trip_kit/model/countryList_model.dart';
import 'package:flutter/material.dart';

class CountryListApi {

  static Future<List<CountryListModel>> getCountryApi(BuildContext context) async{
      final assetBundle = DefaultAssetBundle.of(context);
      final data = await assetBundle.loadString('assets/Country-name.json');
      final body = json.decode(data);
      return body.map<CountryListModel>(CountryListModel.fromJson).toList();

  }
}