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
  Results results = Results();
  UserModel userModel = UserModel();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: const Text("List of Random Users"),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                        // children: [_buildCategoryList()],
                        ),
                  ],
                ),
              ),
            ));
  }

  ClipRRect _buildCategoryList() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: FutureBuilder<List<Results>?>(
            future: getIt<ApiService>().getRandomUsers(),
            builder: (context, snapshot) => !snapshot.hasData
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, snapshot) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(results.picture!.toString()),
                      ),
                      title: Text(
                        results.name.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
