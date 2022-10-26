import 'package:flutter/material.dart';
import 'package:random_user/app/locator.dart';
import 'package:random_user/services/api_service.dart';
import 'package:random_user/shared/simple_alert/simple_alert.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final ApiService _apiService = getIt<ApiService>();

  void pullNewUserFromApi(BuildContext context) async {
    _apiService.getRandomUsers();
  }
}
