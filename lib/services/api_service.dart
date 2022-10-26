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
  Map<String, dynamic>? responseJson;

  Map<String, String> get authRequestHeader => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  handleApiError(error) => log(error, time: DateTime.now());

  Stream<List<UserModel>> getRandomUsers() {
    List<UserModel> categories = [];
    http
        .get(Uri.parse('${_config.apiBaseUrl}'), headers: authRequestHeader)
        .catchError((error) => handleApiError(error))
        .then((response) {
      if (isSuccess(response)) {
        final responseDecode = jsonDecode(response.body);
        categories.addAll(
          responseDecode.map((item) => UserModel.fromJson(item)).toList(),
        );
      }
    });

    return Stream.value(categories);
  }
}
