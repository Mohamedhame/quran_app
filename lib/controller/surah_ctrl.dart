import 'package:flutter/material.dart';
import 'package:quran_app/service/file_storage.dart';
import 'package:quran_app/service/web_scraping.dart';

class SurahCtrl extends ChangeNotifier {
  SurahCtrl({required this.shikhName, required this.url}) {
    loadData();
  }
  final String shikhName;
  final String url;
  bool isLoading = false;
  List surahs = [];

  loadData() async {
    isLoading = true;
    List dataAPI = await WebScraping.readSurahFromWebSiteOrFileJson(
      shikhName: shikhName,
      url: url,
    );
    for (var element in dataAPI) {
      surahs.add({
        "name": element['name'],
        "url": element['url'],
        "isExit": await FileStorage.checkExist(
          dir: shikhName,
          fileName: element['name'],
          format: "mp3"
        ),
      });
    }
    isLoading = false;
    notifyListeners();
  }
}
