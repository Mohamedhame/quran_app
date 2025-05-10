import 'package:flutter/material.dart';
import 'package:quran_app/service/web_scraping.dart';

class ListOfQuraaCtrl extends ChangeNotifier {
  ListOfQuraaCtrl() {
    loadData();
  }
  List quraaNames = [];
  List filterQuraaOnSearch = [];
  loadData() async {
    quraaNames = await WebScraping.readDataFromWebSiteOrJsonFiles();
    filterQuraaOnSearch = quraaNames;
    notifyListeners();
  }

  void runFilterData(String enteredKeyword) {
    List filtered =
        quraaNames
            .where(
              (element) => element['name'].toString().toLowerCase().contains(
                enteredKeyword.toLowerCase(),
              ),
            )
            .toList();
    filterQuraaOnSearch = filtered;
    notifyListeners();
  }
}
