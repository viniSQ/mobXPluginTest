

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
part 'main_screen_controller.g.dart';


class MainScreenController = MainScreenControllerBase with _$MainScreenController;

abstract class MainScreenControllerBase with Store {


  @observable
  List<DocumentSnapshot> groups;

  @action
  void fetchGroups() {
    Firestore.instance.collection('groups').orderBy('title', descending: false).snapshots().listen((snapshot) {
      print("Groups has changed ${snapshot.documents.length}");
      this.groups = snapshot.documents;
    });
  }


}