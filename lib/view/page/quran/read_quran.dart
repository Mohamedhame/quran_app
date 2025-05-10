import 'package:flutter/material.dart';
import 'package:flutter_quran/flutter_quran.dart';

class ReadQuran extends StatelessWidget {
  const ReadQuran({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterQuran().init();
    return Scaffold(body: FlutterQuranScreen());
  }
}
