import 'dart:convert';

import 'package:country_lists/models/countrylistmodel.dart';
import 'package:flutter/services.dart';

class CountryListController {
  int index = 0;

  Future<List<CountryModel>> fetchData() async {
    try {
      String jsonData = await rootBundle.loadString('assets/api/sample.json');
      List<dynamic> data = json.decode(jsonData)['items'];
      return data
          .map((item) => CountryModel.fromJson(item, ++index))
          .toList(); //convert data list of dynamic to the country model object using factory method by mapping them to list
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
