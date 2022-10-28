import 'package:flutter/material.dart';
import 'package:random_user/app/locator.dart';
import 'package:random_user/enums/user_data_enum.dart';
import 'package:random_user/model/user_model.dart';
import 'package:random_user/services/api_service.dart';
import 'package:random_user/shared/simple_alert/simple_alert.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final ApiService _apiService = getIt<ApiService>();
  List<Results>? results;
  List resultsView = [];
  List<Picture>? picture;
  UserModel userModel = UserModel();
  UserDataEnum enumData = UserDataEnum.loading;

  void pullNewUserFromApi(BuildContext context) async { 
    await _apiService.getRandomUsers();
  }

  void initAppWithUser() async {
    if (results == null) {
      setState(UserDataEnum.loading);
    }
    await _apiService.getRandomUsers().then((value) {
      results = _apiService.users;
      resultsView.add(results);
      setState(UserDataEnum.dataReady);
    });
    notifyListeners();
  }

  void setState(UserDataEnum currentEnum) {
    enumData = currentEnum;
    notifyListeners();
  }
}
