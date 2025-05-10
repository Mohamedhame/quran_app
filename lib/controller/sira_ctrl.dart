import 'package:flutter/material.dart';
import 'package:quran_app/controller/sound_play_ctrl.dart';
import 'package:quran_app/service/file_storage.dart';
import 'package:quran_app/service/shared.dart';
import 'package:quran_app/service/web_scraping.dart';
import 'package:quran_app/view/page/sound_play.dart';

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
          format: "mp3",
        ),
      });
    }

    isLoading = false;
    notifyListeners();
  }

  void goToAudio(BuildContext context, SoundPlayCtrl audioCrtl) async {
    Map? data = await Shared.getMusicSira();
    if (data != null) {
      audioCrtl.playAudio(
        data['data'],
        data['index'],
        shihkName: data['shihkName'],
        pos: data['position'].toDouble(),
      );
      audioCrtl.handlePlayPause();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (context) => SoundPlay(
                isSerah: true,
                sikhName: data['shihkName'],
                data: data['data'],
                index: data['index'],
              ),
        ),
      );
    }
  }
}
