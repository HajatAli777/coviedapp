import 'dart:convert';

import 'package:coviedapp/models/worldStates_model.dart';
import 'package:coviedapp/services/utilites/app_urls.dart';
import 'package:http/http.dart' as http;

class StatesServices {

  Future<WorldstatesModel> fetchWorldStatesRecords() async {

    final response = await http.get(Uri.parse(AppUrls.worldStatesApi));

    if (response.statusCode == 200) {

      var data = jsonDecode(response.body);

      return WorldstatesModel.fromJson( data);

    } else {
      throw Exception("Failed to load data");
    }
  }
}