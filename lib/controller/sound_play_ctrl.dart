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
    playr.setLoopMode(isRepeat ? LoopMode.one : LoopMode.off);
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

  Future<void> handleSeek(double value) async {
    playr.seek(Duration(seconds: value.toInt()));
  }

  Future<ConcatenatingAudioSource> initializePlaylist(
    List myList,
    String shikhName,
  ) async {
    List<AudioSource> audioSources = [];

    for (int index = 0; index < myList.length; index++) {
      String url;
      if (await myList[index]['isExit']) {
        url = await FileStorage.urlFile(
          dir: shikhName,
          fileName: myList[index]['name'],
          format: "mp3",
        );
      } else {
        url = myList[index]['url'];
      }

      audioSources.add(
        AudioSource.uri(
          Uri.parse(url),
          tag: MediaItem(
            id: "$index",
            title: myList[index]['name'],
            artist: shikhName,
          ),
        ),
      );
    }

    return ConcatenatingAudioSource(children: audioSources);
  }

  Future<void> initMusic({
    required int startIndex,
    required List myList,
    required String shikhName,
  }) async {
    try {
      await playr.setLoopMode(LoopMode.all);
      ConcatenatingAudioSource playlist = await initializePlaylist(
        myList,
        shikhName,
      );
      await playr.setAudioSource(playlist, initialIndex: startIndex);
      await playr.seek(Duration.zero, index: startIndex);
    } catch (e) {
      log(e.toString());
    }
  }

  //=== Play Song

  void playAudio(
    List myList,
    int index, {
    required String shikhName,
    double? pos,
  }) async {
    if (myList.isEmpty) return;
    isNoInternet = false;
    currentIndex = index;
    title = myList[index]['name'];
    externalData = myList;
    externalShihkName = shikhName;
    notifyListeners();

    try {
      await initMusic(startIndex: index, myList: myList, shikhName: shikhName);
      initPlayerListeners();

      // بدأ التشغيل بعد تحميل القائمة
      if (pos != null) {
        await handleSeek(pos);
      }
      await playr.play();
    } catch (e) {
      log(e.toString());
    }
  }

  //=====================
  void updatePosition() {
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

  void initPlayerListeners() {
    // تحديث حالة المشغل
    playr.playerStateStream.listen((state) {
      if (!state.playing || state.processingState == ProcessingState.idle) {
        _savePlaybackState(
          externalData,
          currentIndex,
          externalShihkName!,
          position.inSeconds,
        );
      }
    });

    // تحديث المؤشر الحالي عند الانتقال التلقائي
    playr.currentIndexStream.listen((index) {
      if (index != null) {
        currentIndex = index;
        title = externalData[index]['name'];
        notifyListeners();
      }
    });

    // التكرار
    playr.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        if (isRepeat) {
          playr.setLoopMode(LoopMode.one);
        } else {
          playr.setLoopMode(LoopMode.off);
        }
      }
    });

    // الموضع والمدة
    playr.positionStream.listen((p) {
      position = p;
      final buffer = playr.bufferedPosition;
      const bufferMargin = Duration(seconds: 2);

      isBufferingEnd = position >= buffer - bufferMargin;
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
      playAudio(data, currentIndex, shikhName: shikh);
      notifyListeners();
    } else {
      currentIndex++;
      playAudio(data, currentIndex, shikhName: shikh);
      notifyListeners();
    }
  }

  void previousMusic(List data, String shikh) {
    if (currentIndex == 0) {
      currentIndex = data.length;
      notifyListeners();
    }
    currentIndex--;
    playAudio(data, currentIndex, shikhName: shikh);
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
