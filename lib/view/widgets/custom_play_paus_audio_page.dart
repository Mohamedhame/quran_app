import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/controller/sound_play_ctrl.dart';

class CustomPlayPausAudioPage extends StatelessWidget {
  const CustomPlayPausAudioPage({
    super.key,
    required this.data,
    required this.shikh,
  });
  final List data;
  final String shikh;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SoundPlayCtrl>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textDirection: TextDirection.rtl,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              InkWell(
                onTap: () {
                  model.nextMusic(data, shikh);
                },
                child: Icon(Icons.skip_next, size: 32, color: Colors.white),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  model.increaseSpeed();
                },
                child: Icon(Icons.fast_forward, size: 32, color: Colors.white),
              ),
            ],
          ),
          Selector<SoundPlayCtrl, bool>(
            builder: (context, value2, child) {
              if (value2) {
                return CircularProgressIndicator();
              } else {
                return Selector<SoundPlayCtrl, bool>(
                  builder: (context, value, child) {
                    return InkWell(
                      onTap: model.handlePlayPause,
                      child: Icon(
                        value ? Icons.pause : Icons.play_arrow,
                        size: 32,
                        color: Colors.white,
                      ),
                    );
                  },
                  selector: (p0, p1) => p1.playr.playing,
                );
              }
            },
            selector: (p0, p1) => p1.isBufferingEnd,
          ),

          Row(
            textDirection: TextDirection.rtl,
            children: [
              InkWell(
                onTap: () {
                  model.decreaseSpeed();
                },
                child: Icon(Icons.fast_rewind, size: 32, color: Colors.white),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  model.previousMusic(data, shikh);
                },
                child: Icon(Icons.skip_previous, size: 32, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
