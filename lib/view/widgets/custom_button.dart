import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/controller/theme_controller.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.textButton, this.onTap});
  final String textButton;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: theme.fontColor),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                textButton,
                style: GoogleFonts.amiri(color: theme.fontColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
