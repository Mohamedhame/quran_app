import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static SharedPreferences? _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  static Future<void> setTheme(bool theme) async {
    await init();
    await _sharedPreferences!.setBool("theme", theme);
  }

  static Future<bool?> getTheme() async {
    await init();
    return _sharedPreferences!.getBool("theme");
  }

  static Future<void> setMusicQuran(Map<String, dynamic> value) async {
    await init();
    String jsonString = jsonEncode(value);
    await _sharedPreferences!.setString("save", jsonString);
    log("setMusicQuran");
  }

  static Future<Map<String, dynamic>?> getMusicQuran() async {
    await init();
    String? jsonString = _sharedPreferences!.getString('save');
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }

  static Future<void> setMusicSira(Map<String, dynamic> value) async {
    await init();
    String jsonString = jsonEncode(value);
    await _sharedPreferences!.setString("sira", jsonString);
    log("setMusicSira");
  }

  static Future<Map<String, dynamic>?> getMusicSira() async {
    await init();
    String? jsonString = _sharedPreferences!.getString('sira');
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }
}
