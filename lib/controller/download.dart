import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/functions/check_internet.dart';
import 'package:quran_app/service/file_storage.dart';

class Download extends ChangeNotifier {
  static CancelToken _cancelToken = CancelToken();
  double _progress = 0.0;
  bool _isDownloding = false;
  int _currentIndex = 0;
  bool _noInternet = false;
  bool isCompleted = false;

  int get currentIndex => _currentIndex;
  set currentIndex(int i) {
    _currentIndex = i;
    notifyListeners();
  }

  bool get noInternet => _noInternet;
  set noInternet(bool i) {
    _noInternet = i;
    notifyListeners();
  }

  bool get isDownloding => _isDownloding;
  set isDownloding(bool d) {
    _isDownloding = d;
    notifyListeners();
  }

  double get progress => _progress;
  set progress(double p) {
    _progress = p;
    notifyListeners();
  }

  Future<void> startDownload({
    required String dir,
    required String fileName,
    required String url,
    required String format,
  }) async {
    if (!await checkInternet()) {
      log("🚫 لا يوجد اتصال بالإنترنت.");
      noInternet = true;
      notifyListeners();
      return;
    }

    String pathDirectory = await FileStorage.getPath(dir);
    String pathFile = "$pathDirectory/$fileName.$format";
    final File file = File(pathFile);
    int downloadedLength = 0;
    try {
      if (await file.exists()) {
        downloadedLength = await file.length();
      }

      final raf = await file.open(mode: FileMode.append);

      final response = await Dio().get<ResponseBody>(
        url,
        options: Options(
          responseType: ResponseType.stream,
          headers: {"range": "bytes=$downloadedLength-"},
        ),
        cancelToken: _cancelToken,
      );

      int received = 0;
      int total = response.data?.contentLength ?? 0;
      if (total == 0) {
        log("⚠️ إجمالي الحجم غير معروف!");
        return;
      }

      isDownloding = true;

      await for (var chunk in response.data!.stream) {
        if (_cancelToken.isCancelled) {
          break;
        }
        await raf.writeFrom(chunk);
        received += chunk.length;
        progress = ((downloadedLength + received) / total) * 100;
        notifyListeners();
      }
      await raf.close();
      log("✅ التحميل اكتمل: $fileName");
      isCompleted = true;
      isDownloding = false;
      notifyListeners();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        log("⚠️ تم إلغاء التحميل.");
      } else {
        log("❌ خطأ أثناء التحميل: $e");
      }
    } catch (e) {
      log("❌ خطأ غير متوقع: $e");
    } finally {
      isDownloding = false;
      progress = 0.0;
      notifyListeners();
    }
  }

  void cancel() {
    _cancelToken.cancel();
    _cancelToken = CancelToken();
    isDownloding = false;
    progress = 0.0;
    notifyListeners();
  }
}
