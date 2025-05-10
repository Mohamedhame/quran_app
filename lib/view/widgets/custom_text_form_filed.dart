import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/controller/theme_controller.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, this.label, required this.theme, this.onChanged});
  final String? label;
  final ThemeController theme;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: onChanged,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          label: Text(
            label ?? "",
            style: GoogleFonts.amiri(color: theme.fontColor),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
