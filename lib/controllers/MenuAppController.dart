import 'package:flutter/material.dart';

class MenuAppController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    // ignore: null_aware_in_logical_operator
    if (!_scaffoldKey.currentState?.isDrawerOpen) {
      _scaffoldKey.currentState?.openDrawer();
    }
  }
}
