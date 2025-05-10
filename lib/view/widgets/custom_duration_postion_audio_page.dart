import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/controller/sound_play_ctrl.dart';
import 'package:quran_app/functions/format_duration.dart';

class CustomDurationPostionAudioPage extends StatelessWidget {
  const CustomDurationPostionAudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textDirection: TextDirection.rtl,
        children: [
          Selector<SoundPlayCtrl, Duration>(
            builder: (context, value, child) {
              return Text(
              formatDuration(value),
                style: TextStyle(color: Colors.white),
              );
            },
            selector: (p0, p1) => p1.position,
          ),
          Selector<SoundPlayCtrl, Duration>(
            builder: (context, value, child) {
              return Text(
                formatDuration(value),
                style: TextStyle(color: Colors.white),
              );
            },
            selector: (p0, p1) => p1.duration,
          ),
        ],
      ),
    );
  }
}
