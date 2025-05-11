import 'package:flutter/material.dart';
import 'package:flutter_quran/flutter_quran.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class ReadQuranCtrl extends ChangeNotifier {
  ReadQuranCtrl() {
    WakelockPlus.enable();
    init();
  }

  bool showBottomWidget = true;
  bool useDefaultAppBar = true;

  hideAppearAppBarAndBottom() {
    showBottomWidget = !showBottomWidget;
    useDefaultAppBar = !useDefaultAppBar;
    notifyListeners();
  }

  init() {
    FlutterQuran().init();
    notifyListeners();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }
}
