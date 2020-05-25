// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_group_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddGroupController on AddGroupControllerBase, Store {
  final _$loadingAtom = Atom(name: 'AddGroupControllerBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$AddGroupControllerBaseActionController =
      ActionController(name: 'AddGroupControllerBase');

  @override
  void setLoading(bool flag) {
    final _$actionInfo = _$AddGroupControllerBaseActionController.startAction(
        name: 'AddGroupControllerBase.setLoading');
    try {
      return super.setLoading(flag);
    } finally {
      _$AddGroupControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading}
    ''';
  }
}
