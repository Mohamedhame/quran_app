import 'dart:convert';
import 'dart:developer';

import 'package:chaleno/chaleno.dart';
import 'package:quran_app/functions/check_internet.dart';
import 'package:quran_app/service/save_data_in_file_json.dart';

class WebScraping {
  // Get Quraa from Internet Or json files
  static Future<List> readDataFromWebSiteOrJsonFiles() async {
    List<Map<String, dynamic>> names = [];
    final readFromJson = await SaveDataInFileJson.read('quraa.json');
    if (readFromJson.isNotEmpty) {
      log("From Json");
      return readFromJson;
    } else {
      log("From Internet");

      if (await checkInternet()) {
        final data = getQuraa();

        for (var element in await data) {
          names.add({"name": element['name'], "url": element['url']});
        }
        String updatedJsonString = jsonEncode(names);
        await SaveDataInFileJson.writeTemp('quraa.json', updatedJsonString);
      }
      return names;
    }
  }

  // Get Surahs from Internet Or json files
  static Future<List> readSurahFromWebSiteOrFileJson({
    required String shikhName,
    required String url,
  }) async {
    List<Map<String, dynamic>> names = [];
    final readFromJson = await SaveDataInFileJson.read('$shikhName.json');
    if (readFromJson.isNotEmpty) {
      log("From Json");
      return readFromJson;
    } else {
      log("From Internet");
      if (await checkInternet()) {
        final data = await getQuran(url);
        for (var element in data) {
          names.add({"name": "${element['name']}", "url": "${element['url']}"});
        }

        String updatedJsonString = jsonEncode(names);
        await SaveDataInFileJson.writeTemp(
          '$shikhName.json',
          updatedJsonString,
        );
      }
      return names;
    }
  }

  // Get names of quraa from ourquraan webSite
  static Future<List> getQuraa() async {
    List data = [];
    String url = "https://ourquraan.com";
    final chaleno = await Chaleno().load(url);
    var results = chaleno!.querySelectorAll('p');
    for (var result in results) {
      var anchor = result.querySelector('a');
      if (anchor != null) {
        data.add({"name": anchor.text, "url": anchor.href});
      }
    }

    return data;
  }

  static Future<List> getQuran(String url) async {
    List data = [];
    final chaleno = await Chaleno().load(url);

    var results = chaleno!.getElementsByClassName('btn btn-black');

    for (var result in results) {
      var anchors = result.querySelectorAll('a');

      for (var anchor in anchors!) {
        if (anchor.href != null && anchor.href!.contains("download")) {
          data.add({"name": result.text!.trim(), "url": anchor.href});
          break;
        }
      }
    }

    return data;
  }

  // Get names Sira from ourquraan webSite
  static Future<List> readDataFromSerahTable() async {
    List names = [];
    final readFromJson = await SaveDataInFileJson.readSerah('serah.json');
    if (readFromJson.isNotEmpty) {
      log("From Json");
      readFromJson.sort((a, b) => a['id'].compareTo(b['id']));
      return readFromJson;
    } else {
      log("From Supabase");

      if (await checkInternet()) {
        List data = await getSira();
        data.sort((a, b) => a['id'].compareTo(b['id']));
        names.addAll(data);
        String updatedJsonString = jsonEncode(names);
        await SaveDataInFileJson.writeTemp('serah.json', updatedJsonString);
      }

      return names;
    }
  }

  static Future<List> getSiraMaca() async {
    List data = [];
    String url = "https://ar.islamway.net/collection/3621/";
    final chaleno = await Chaleno().load(url);
    int id = 0;
    var results = chaleno!.getElementsByClassName('entry row entry-new');
    for (var result in results) {
      var anchor = result.querySelector('a');
      var a = result.querySelectorAll('ul a');
      for (var element in a!) {
        if (element.href != null && element.href!.contains("download")) {
          String? url = element.href;
          if (id == 7) {
            url =
                "https://ia600304.us.archive.org/23/items/Sarjani_uP_bY_mUSLEm/032_uP_bY_mUSLEm.Ettounssi.mp3";
          }
          data.add({"id": id, "name": anchor!.text!.trim(), "url": url});
          id++;
          break;
        }
      }
    }
    return data;
  }

  static Future<List> getSira() async {
    List data = [];
    String url = "https://ar.islamway.net/collection/4372/";
    final chaleno = await Chaleno().load(url);
    List d = await getSiraMaca();
    data.addAll(d);
    int id = d.length;
    var results = chaleno!.getElementsByClassName('entry row entry-new');
    for (var result in results) {
      var anchor = result.querySelector('a');
      var a = result.querySelectorAll('ul a');
      for (var element in a!) {
        if (element.href != null && element.href!.contains("download")) {
          String? url = element.href;
          data.add({"id": id, "name": anchor!.text!.trim(), "url": url});
          id++;
          break;
        }
      }
    }

    return data;
  }
}
