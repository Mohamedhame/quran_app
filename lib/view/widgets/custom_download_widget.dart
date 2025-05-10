import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/controller/download.dart';
import 'package:quran_app/controller/theme_controller.dart';

class CustomDownloadWidget extends StatelessWidget {
  const CustomDownloadWidget({
    super.key,
    required this.index,
    required this.value,
    required this.dir,
    required this.data,
    required this.theme,
  });

  final int index;
  final Download value;
  final String dir;
  final List data;
  final ThemeController theme;

  @override
  Widget build(BuildContext context) {
    return Selector<Download, bool>(
      selector:
          (context, value) => value.isDownloding && value.currentIndex == index,
      builder: (context, isDownloading, child) {
        return InkWell(
          onTap: () async {
            value.isDownloding = !value.isDownloding;
            value.currentIndex = index;

            if (value.isDownloding) {
              await value.startDownload(
                dir: dir,
                fileName: data[index]['name'],
                url: data[index]['url'],
                format: "mp3",
              );
              if (value.noInternet) {}
            } else {
              value.cancel();
            }
          },
          child:
              isDownloading
                  ? Selector<Download, double>(
                    selector: (context, value) => value.progress,
                    builder: (context, progress, child) {
                      return CircularPercentIndicator(
                        radius: 15,
                        percent: progress / 100,
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.redAccent,
                        backgroundColor: Colors.greenAccent,
                      );
                    },
                  )
                  : value.isCompleted
                  ? Icon(Icons.check, color: theme.fontColor)
                  : Icon(Icons.download, color: theme.fontColor),
        );
      },
    );
  }
}