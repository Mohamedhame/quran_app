import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:quran_app/functions/check_internet.dart';
import 'package:quran_app/service/file_storage.dart';
import 'package:quran_app/service/shared.dart';

class SoundPlayCtrl extends ChangeNotifier {
  final playr = AudioPlayer();
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  bool isNoInternet = false;
  int _currentIndex = 0;
  double speed = 1.0;
  String? title;
  bool isBufferingEnd = false;
  List<double> speedList = [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];
  int get currentIndex => _currentIndex;
  set currentIndex(int c) {
    _currentIndex = c;
    notifyListeners();
  }

  bool isRepeat = false;
  bool? isPlaydirctly;
  List externalData = [];
  String? externalShihkName;

  void changeRepeat() {
    isRepeat = !isRepeat;
    notifyListeners();
  }

  void handlePlayPause() async {
    if (await checkInternet()) {
      isNoInternet = false;
      notifyListeners();
    }

    if (playr.playing) {
      await playr.pause();
    } else {
      await playr.play();
    }
  }

  void handleSeek(double value) {
    playr.seek(Duration(seconds: value.toInt()));
  }

  Future<void> playAudio(
    List data,
    int index, {
    String? shihkName,
    double? pos,
  }) async {
    if (data.isEmpty) return;
    isNoInternet = false;
    currentIndex = index;
    title = data[index]['name'];
    externalData = data;
    externalShihkName = shihkName;

    String path;

    try {
      if (await FileStorage.checkExist(
        dir: data[currentIndex]['name'],
        fileName: shihkName!,
        format: "mp3",
      )) {
        path = await FileStorage.urlFile(
          dir: shihkName,
          fileName: data[currentIndex]['name'],
          format: "mp3",
        );
      } else {
        path = data[currentIndex]['url'];
        isNoInternet = !(await checkInternet());
      }

      await playr.setAudioSource(
        AudioSource.uri(
          Uri.parse(path),
          tag: MediaItem(
            id: "1",
            title: data[currentIndex]['name'],
            artist: shihkName,
          ),
        ),
      );

      if (pos != null) {
        handleSeek(pos);
      }

      playr.positionStream.listen((p) {
        position = p;
        final buffer = playr.bufferedPosition;
        const bufferMargin = Duration(seconds: 2);

        if (position >= buffer - bufferMargin) {
          isBufferingEnd = true;
        } else {
          isBufferingEnd = false;
        }

        notifyListeners();
      });

      playr.durationStream.listen((d) {
        if (d != null) {
          duration = d;
          notifyListeners();
        }
      });

      initPlayerListeners();
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  void initPlayerListeners() {
    playr.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        if (isRepeat) {
          playAudio(externalData, currentIndex, shihkName: externalShihkName);
        } else {
          nextMusic(externalData, externalShihkName!);
        }
      }

      if (!state.playing || state.processingState == ProcessingState.idle) {
        _savePlaybackState(
          externalData,
          currentIndex,
          externalShihkName!,
          position.inSeconds,
        );
      }
    });

    playr.positionStream.listen((p) {
      position = p;

      final buffer = playr.bufferedPosition;
      const bufferMargin = Duration(seconds: 2);
      if (position >= buffer - bufferMargin) {
        isBufferingEnd = true;
      } else {
        isBufferingEnd = false;
      }

      notifyListeners();
    });

    playr.durationStream.listen((d) {
      if (d != null) {
        duration = d;
        notifyListeners();
      }
    });
  }

  void _savePlaybackState(List data, int index, String shihkName, int pos) {
    log(shihkName);
    if (shihkName == "الدكتور راغب السرجاني") {
      Shared.setMusicSira({
        "data": data,
        "shihkName": shihkName,
        "index": index,
        "position": pos,
      });
    } else {
      Shared.setMusicQuran({
        "data": data,
        "shihkName": shihkName,
        "index": index,
        "position": pos,
      });
    }
  }

  void nextMusic(List data, String shikh) {
    if (currentIndex == data.length - 1) {
      currentIndex = 0;
      playAudio(data, currentIndex);
      notifyListeners();
    } else {
      currentIndex++;
      playAudio(data, currentIndex, shihkName: shikh);
      notifyListeners();
    }
  }

  void previousMusic(List data, String shikh) {
    if (currentIndex == 0) {
      currentIndex = data.length;
      notifyListeners();
    }
    currentIndex--;
    playAudio(data, currentIndex, shihkName: shikh);
    notifyListeners();
  }

  void increaseSpeed() {
    if (speed < 2.0) {
      speed += 0.05;
      playr.setSpeed(speed);
      notifyListeners();
    }
  }

  void decreaseSpeed() {
    if (speed > 0.5) {
      speed -= 0.05;
      playr.setSpeed(speed);
      notifyListeners();
    }
  }

  void setSpeed(double nweSpeed) {
    speed = nweSpeed;
    playr.setSpeed(speed);
    notifyListeners();
  }
}
