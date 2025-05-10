import 'package:flutter/material.dart';
import 'package:quran_app/service/file_storage.dart';
import 'package:quran_app/service/web_scraping.dart';

class SiraCtrl extends ChangeNotifier {
  SiraCtrl() {
    loadData();
  }
  List siraData = [];
  bool isLoading = false;

  loadData() async {
    isLoading = true;
    List dataAPI = await WebScraping.readDataFromSerahTable();

    for (var element in dataAPI) {
      siraData.add({
        "name": element['name'],
        "url": element['url'],
        "isExit": await FileStorage.checkExist(
          dir: "الدكتور راغب السرجاني",
          fileName: element['name'],
        ),
      });
    }

    isLoading = false;
    notifyListeners();
  }
}
