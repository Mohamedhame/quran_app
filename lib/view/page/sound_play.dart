import 'package:flutter/material.dart';
import 'package:quran_app/view/widgets/box_decoration_audio.dart';
import 'package:quran_app/view/widgets/custom_duration_postion_audio_page.dart';
import 'package:quran_app/view/widgets/custom_image_audio_page.dart';
import 'package:quran_app/view/widgets/custom_play_paus_audio_page.dart';
import 'package:quran_app/view/widgets/custom_repeat_audio_page.dart';
import 'package:quran_app/view/widgets/custom_show_speed_audio_page.dart';
import 'package:quran_app/view/widgets/custom_slider_audio_page.dart';

class SoundPlay extends StatelessWidget {
  const SoundPlay({
    super.key,
    required this.sikhName,
    required this.isSerah,
    required this.data,
    required this.index,
  });
  final String sikhName;
  final bool isSerah;
  final List data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        body: DecoratedBox(
          decoration: decorationAudioPage,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CustomImage(isSira: isSerah, sikhName: sikhName),
                  const SizedBox(height: 10),
                  const CustomSliderAudioPage(),
                  const CustomDurationPostionAudioPage(),
                  const SizedBox(height: 20),
                  CustomPlayPausAudioPage(data: data, shikh: sikhName),
                  const SizedBox(height: 20),
                  const CustomRepeatAudioPage(),
                  const CustomShowSpeedAudioPage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
