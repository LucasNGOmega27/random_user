import 'package:flutter/material.dart';
import 'package:random_user/app/locator.dart';
import 'package:random_user/enums/user_data_enum.dart';
import 'package:random_user/model/user_model.dart';
import 'package:random_user/services/api_service.dart';
import 'package:random_user/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with ChangeNotifier {
  final HomeViewModel _model = getIt<HomeViewModel>();
  Map<String, dynamic>? viewData;
  @override
  void initState() {
    super.initState();
    _model.initAppWithUser();
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
        floatingActionButton: FloatingActionButton(
          tooltip: "Create a new user",
          child: const Icon(Icons.add),
          onPressed: () {
            model.initAppWithUser();
          },
        ),
        body: (model.enumData == UserDataEnum.loading)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: model.resultsView.length,
                itemBuilder: (context, index) => ListTile(
                  leading: Hero(
                    tag: "image$index",
                    child: CircleAvatar(
                        backgroundImage:
                            model.resultsView[index].picture.toString().isEmpty
                                ? NetworkImage(
                                    model.resultsView[index].picture[index])
                                : null),
                  ),
                  title: Text(
                    model.resultsView[index].name.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
