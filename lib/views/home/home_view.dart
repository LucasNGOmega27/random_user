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
                      children: [],
                    ),
                    insertButton(model.pullNewUserFromApi(context)),
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
          child: StreamBuilder<List<UserModel>>(
            stream: getIt<ApiService>().getRandomUsers(),
            builder: (context, snapshot) => !snapshot.hasData
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) => ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 15.0, bottom: 15),
                      dense: true,
                      leading: _userImage(snapshot, index),
                      title: _userName(snapshot, index),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Text _userName(AsyncSnapshot<List<Results>> snapshot, int index) {
    return Text(
      snapshot.data![index].name.toString(),
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  CircleAvatar _userImage(AsyncSnapshot<List<Picture>> snapshot, int index) {
    return CircleAvatar(
        foregroundColor: Colors.white,
        child: Image.network(snapshot.data![index].medium.toString()));
  }

  Widget _filterUsers() {
    return Container();
  }

  Widget insertButton(void onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.shade900,
      ),
      onPressed: () async => onPressed,
      child: const Icon(
        Icons.add,
        color: Colors.white70,
      ),
    );
  }
}
