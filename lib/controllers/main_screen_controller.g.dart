// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_screen_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainScreenController on MainScreenControllerBase, Store {
  final _$groupsAtom = Atom(name: 'MainScreenControllerBase.groups');

  @override
  List<DocumentSnapshot> get groups {
    _$groupsAtom.reportRead();
    return super.groups;
  }

  @override
  set groups(List<DocumentSnapshot> value) {
    _$groupsAtom.reportWrite(value, super.groups, () {
      super.groups = value;
    });
  }

  final _$MainScreenControllerBaseActionController =
      ActionController(name: 'MainScreenControllerBase');

  @override
  void fetchGroups() {
    final _$actionInfo = _$MainScreenControllerBaseActionController.startAction(
        name: 'MainScreenControllerBase.fetchGroups');
    try {
      return super.fetchGroups();
    } finally {
      _$MainScreenControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
groups: ${groups}
    ''';
  }
}
