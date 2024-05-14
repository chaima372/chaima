import 'dart:convert';
import 'dart:developer';
import 'package:flutter_application_stage_project/models/modelApp/modelTable.dart';
import 'package:flutter_application_stage_project/services/login/sharedPreference.dart';
import 'package:http/http.dart' as http;

class DataService {
  Future<List<DataModelTable>> fetchData(String idFamily) async {
    final token = await SharedPrefernce.getToken("token");
    final url =
        "https://spherebackdev.cmk.biz:4543/index.php/api/mobile/get-elements-by-family/${idFamily}";
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      log(response.body);
      final jsonData = json.decode(response.body);
      final data = jsonData['data'] as List<dynamic>;
      return data.map((item) => DataModelTable.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}

////search///
Future<List<DataModelTable>> getSearchTable(
    String idFamily, String searchtable) async {
  final token = await SharedPrefernce.getToken("token");
  final url =
      "https://spherebackdev.cmk.biz:4543/index.php/api/mobile/get-elements-by-family/${idFamily}?search${searchtable}";
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
    log(response.body);
    final jsonData = json.decode(response.body);
    final data = jsonData['data'] as List<dynamic>;
    return data.map((item) => DataModelTable.fromJson(item)).toList();
  } else {
    throw Exception('Failed to fetch data');
  }
}
