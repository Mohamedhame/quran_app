import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/controller/download.dart';
import 'package:quran_app/controller/theme_controller.dart';
import 'package:quran_app/view/widgets/custom_download_widget.dart';

class CustomDownloadOrCheckIconAndPalyIcon extends StatelessWidget {
  const CustomDownloadOrCheckIconAndPalyIcon({
    super.key,
    required this.theme,
    required this.data,
    required this.index,
    required this.dir,
  });
  final ThemeController theme;
  final List data;
  final int index;
  final String dir;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.play_arrow, color: theme.fontColor),
        const SizedBox(width: 10),
        data[index]['isExit']
            ? Icon(Icons.check, color: theme.fontColor)
            : ChangeNotifierProvider(
              create: (context) => Download(),
              builder: (context, c) {
                final value = context.read<Download>();
                return value.isCompleted
                    ? Icon(Icons.check, color: theme.fontColor)
                    : CustomDownloadWidget(
                      index: index,
                      value: value,
                      dir: dir,
                      data: data,
                      theme: theme,
                    );
              },
            ),
      ],
    );
  }
}


