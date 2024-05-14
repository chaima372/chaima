// Fonction pour récupérer les données à partir de l'API
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application_stage_project/models/modelApp/model_info.dart';
import 'package:flutter_application_stage_project/services/login/sharedPreference.dart';
import 'package:http/http.dart' as http;

Future<Module> getDealInfoModel(String idElement) async {
  final token = await SharedPrefernce.getToken("token");
  final url =
      "https://spherebackdev.cmk.biz:4543/index.php/api/mobile/get-element-by-id/$idElement";

  // Log before making the HTTP request
  log('Fetching stages from: $url');

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    // Log the HTTP status code
    log('HTTP response status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      // Log the successful response body
      log('Response body: ${response.body}');
      return Module.fromJson(jsonDecode(response.body));
    } else {
      // Si la requête a échoué, lancez une exception ou gérez l'erreur selon votre logique
      throw Exception(
          'Failed to load data. HTTP status code: ${response.statusCode}');
    }
  } catch (error) {
    // Log any errors that occur during the process
    log('Error fetching data: $error');
    // Re-throw the error to propagate it upwards
    throw error;
  }
}
