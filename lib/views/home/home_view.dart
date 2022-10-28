import 'package:flutter/material.dart';
import 'package:random_user/app/locator.dart';
import 'package:random_user/model/user_model.dart';
import 'package:random_user/services/api_service.dart';
import 'package:random_user/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Results>? results;
  UserModel userModel = UserModel();
  ApiService apiService = getIt<ApiService>();
  Map<String, dynamic>? viewData;
  @override
  void initState() {
    super.initState();
    apiService.getRandomUsers().then((value) {
      results = apiService.users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text("List of Random Users"),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: results?.length,
          itemBuilder: (context, index) => ListTile(
            leading: Hero(
              tag: "image$index",
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(results![index].picture.toString()),
              ),
            ),
            title: Text(
              results![index].name.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
