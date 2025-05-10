import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/controller/list_of_quraa_ctrl.dart';
import 'package:quran_app/utilities/routes.dart';
import 'package:quran_app/view/page/home_page.dart';
import 'package:quran_app/view/page/list_of_quraa.dart';
import 'package:quran_app/view/page/read_quran.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.readQuran:
      return CupertinoPageRoute(
        builder: (_) => const ReadQuran(),
        settings: settings,
      );
    case AppRoutes.listOfQurra:
      return CupertinoPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (context) => ListOfQuraaCtrl(),
          child: ListOfQuraa(),
        ),
        settings: settings,
      );
    default:
      return CupertinoPageRoute(
        builder: (_) => const HomePage(),
        settings: settings,
      );
  }
}
