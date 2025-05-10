import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/controller/theme_controller.dart';

class CustomItemInListView extends StatelessWidget {
  const CustomItemInListView({
    super.key,
    required this.theme,
    required this.titleItem,
    this.onTap,
    this.widget,
  });

  final ThemeController theme;
  final String titleItem;
  final void Function()? onTap;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: theme.fontColor),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment:
                  widget == null
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  titleItem,
                  style: GoogleFonts.amiri(color: theme.fontColor),
                ),
                if (widget != null) widget!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
