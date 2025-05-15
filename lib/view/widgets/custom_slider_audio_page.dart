import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/controller/sound_play_ctrl.dart';

class CustomSliderAudioPage extends StatelessWidget {
  const CustomSliderAudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SoundPlayCtrl>(context, listen: false);
    return Selector<SoundPlayCtrl, double>(
      selector: (p0, p1) => p1.position.inSeconds.toDouble(),
      builder: (context, value, child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Slider(
            min: 0.0,
            max:
                model.duration.inSeconds > 0
                    ? model.duration.inSeconds.toDouble()
                    : 1.0,
            value: value.clamp(
              0.0,
              model.duration.inSeconds > 0
                  ? model.duration.inSeconds.toDouble()
                  : 1.0,
            ),
            onChanged: model.handleSeek,
          ),
        );
      },
    );
  }
}
