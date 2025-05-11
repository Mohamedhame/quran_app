import 'package:flutter/material.dart';
import 'package:quran_app/controller/sound_play_ctrl.dart';
import 'package:quran_app/service/file_storage.dart';
import 'package:quran_app/service/shared.dart';
import 'package:quran_app/service/web_scraping.dart';
import 'package:quran_app/view/page/sound_play.dart';

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
          format: "mp3",
        ),
      });
    }
    isLoading = false;
    notifyListeners();
  }

  void goToAudio(BuildContext context, SoundPlayCtrl audioCrtl) async {
    Map? data = await Shared.getMusicQuran();
    if (data!['shihkName'] == shikhName) {
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
                isSerah: false,
                sikhName: data['shihkName'],
                data: data['data'],
                index: data['index'],
              ),
        ),
      );
    }
  }
}
