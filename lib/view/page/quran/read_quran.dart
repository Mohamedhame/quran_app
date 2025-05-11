import 'package:flutter/material.dart';
import 'package:flutter_quran/flutter_quran.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/controller/read_quran_ctrl.dart';

class ReadQuran extends StatelessWidget {
  const ReadQuran({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReadQuranCtrl(),
      child: Scaffold(
        body: Consumer<ReadQuranCtrl>(
          builder: (context, model, child) {
            return InkWell(
              onTap: model.hideAppearAppBarAndBottom,
              child: FlutterQuranScreen(
                showBottomWidget: model.showBottomWidget,
                useDefaultAppBar: model.useDefaultAppBar,
              ),
            );
          },
        ),
      ),
    );
  }
}
