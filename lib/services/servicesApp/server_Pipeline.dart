import 'dart:convert';
import 'package:flutter_application_stage_project/models/modelApp/model_pipeline.dart';
import 'package:flutter_application_stage_project/services/login/sharedPreference.dart';
import 'package:http/http.dart' as http;

Future<PipelineModel> getPipeline(String idFamily) async {
  final token = await SharedPrefernce.getToken("token");
  final url =
      "https://spherebackdev.cmk.biz:4543/index.php/api/mobile/pipelines-by-family/${idFamily}";
  try {
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // If the request is successful, parse the JSON response
      final jsonData = jsonDecode(response.body);

      return PipelineModel.fromJson(jsonData);
    } else {
      // If the request fails, throw an exception or handle the error accordingly
      throw Exception('Failed to load Kanban data');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
