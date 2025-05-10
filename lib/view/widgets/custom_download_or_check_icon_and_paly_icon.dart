import 'package:flutter/material.dart';
import 'package:quran_app/controller/theme_controller.dart';

class CustomDownloadOrCheckIconAndPalyIcon extends StatelessWidget {
  const CustomDownloadOrCheckIconAndPalyIcon({
    super.key,
    required this.theme,
    required this.isExit,
  });
  final ThemeController theme;
  final bool isExit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.play_arrow, color: theme.fontColor),
        const SizedBox(width: 10),
        isExit
            ? Icon(Icons.check)
            : Icon(Icons.download, color: theme.fontColor),
      ],
    );
  }
}
