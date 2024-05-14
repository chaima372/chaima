import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application_stage_project/models/modelApp/model_kanban.dart';
import 'package:flutter_application_stage_project/services/login/sharedPreference.dart';
import 'package:http/http.dart' as http;

// Fonction pour récupérer les données à partir de l'API
Future<DataModelKanban> getDataModelKanban(int idPepeline) async {
  final token = await SharedPrefernce.getToken("token");
  final url =
      "https://spherebackdev.cmk.biz:4543/index.php/api/mobile/kanban/$idPepeline";

  log('Fetching stages...$url'); // Log before making the HTTP request
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    // Si la requête est réussie, convertissez les données JSON en un objet DataModel
    return DataModelKanban.fromJson(jsonDecode(response.body));
  } else {
    // Si la requête a échoué, lancez une exception ou gérez l'erreur selon votre logique
    throw Exception('Failed to load data');
  }
}

////search///
Future<DataModelKanban> getSearchkanban(int idPepeline, String search) async {
  final token = await SharedPrefernce.getToken("token");
  final url =
      "https://spherebackdev.cmk.biz:4543/index.php/api/mobile/kanban/${idPepeline}?search=${search}";

  log('Fetching stages...$url'); // Log before making the HTTP request
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    // Si la requête est réussie, convertissez les données JSON en un objet DataModel
    return DataModelKanban.fromJson(jsonDecode(response.body));
  } else {
    // Si la requête a échoué, lancez une exception ou gérez l'erreur selon votre logique
    throw Exception('Failed to load data');
  }
}

//// postStage/////
Future<void> postStage(
    int newStageId, String idElement, String idFamily) async {
  final token = await SharedPrefernce.getToken("token");

  String apiUrl =
      'https://spherebackdev.cmk.biz:4543/api/mobile/update-stage-family/${idFamily}';
  log('Fetching stages...$apiUrl');
  // Définir les paramètres de la requête
  Map<String, dynamic> queryParams = {
    'new_stage_id': newStageId,
    'id_element': idElement,
  };

  // Convertir les paramètres en chaîne de requête
  String queryString = Uri(
      queryParameters: queryParams
          .map((key, value) => MapEntry(key, value.toString()))).query;
  log('Fetching stages2...$queryString');
  // Créer l'URL complète avec les paramètres de la requête
  String fullUrl = '$apiUrl?$queryString';
  log('Fetching stages3...$fullUrl');

  try {
    // Envoyer la requête POST vide
    http.Response response = await http.post(
      Uri.parse(fullUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    // Vérifier le code de statut de la réponse
    if (response.statusCode == 200) {
      // Succès, la requête a été traitée avec succès

      log('Fetching stages4...${response.body}');
    } else {
      // Erreur, la requête a échoué
      log('Failed with status code: ${response.statusCode}');
    }
  } catch (e) {
    // Erreur lors de l'envoi de la requête
    log('Error: $e');
  }
}
