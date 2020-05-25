

import 'package:mobx/mobx.dart';
part 'add_group_controller.g.dart';


class AddGroupController = AddGroupControllerBase with _$AddGroupController;

abstract class AddGroupControllerBase with Store {

  @observable
  bool loading = false;

  @action
  void setLoading(bool flag) {
    loading = flag;
  }

}