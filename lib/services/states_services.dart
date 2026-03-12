import 'dart:convert';

import 'package:coviedapp/services/utilites/app_urls.dart';
import 'package:coviedapp/views/worlds_states.dart';
import 'package:http/http.dart' as http;

class StatesServices {

  Future<WorldsStates> fetchWorldStatesRecords() async {

    final response = await http.get(Uri.parse(AppUrls.worldStatesApi));

    if (response.statusCode == 200) {

      final Map<String, dynamic> data = jsonDecode(response.body);

      return WorldsStates.fromJson(data);

    } else {
      throw Exception("Failed to load data");
    }
  }
}