// ignore_for_file: unnecessary_string_interpolations

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:random_user/app/config.dart';
import 'package:random_user/app/locator.dart';
import 'package:random_user/model/user_model.dart';

class ApiService {
  final Config _config = getIt<Config>();
  bool isSuccess(http.Response response) =>
      response.statusCode == 200 || response.statusCode == 201;
  List<Results>? users = [];
  var responseJson;
  Map<String, String> get authRequestHeader => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  handleApiError(error) => log(error, time: DateTime.now());
  
  Future<List<Results>?> getRandomUsers() async {
    final response = await http
        .get(Uri.parse('${_config.apiBaseUrl}'))
        .catchError((error) => handleApiError(error))
        .timeout(const Duration(seconds: 30));
    if (isSuccess(response)) {
      responseJson = json.decode(response.body);
      UserModel userModel = UserModel.fromJson(responseJson);
      users = userModel.results;
    }
    return users;
  }
}
