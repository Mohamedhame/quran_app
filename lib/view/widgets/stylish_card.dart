import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/controller/theme_controller.dart';
import 'package:quran_app/functions/opacity_to_alph.dart';

class StylishCard extends StatelessWidget {
  const StylishCard({
    super.key,
    required this.title,
    required this.body,
    required this.footer,
  });
  final String title;
  final String body;
  final String footer;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.fontColor.withAlpha(opacityToAlpha(0.5)),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.primaryColor.withAlpha(opacityToAlpha(0.5)),
                offset: const Offset(0, 2),
                blurRadius: 8,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: title,
                        style: GoogleFonts.amiri(
                          fontSize: 18,
                          height: 1.8,
                          color: theme.primaryColor,
                        ),
                      ),
                      TextSpan(
                        text: '$body\n\n',
                        style: GoogleFonts.amiri(
                          fontSize: 18,
                          height: 1.8,
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: footer,
                        style: GoogleFonts.amiri(
                          fontSize: 18,
                          height: 1.8,
                          color: theme.primaryColor.withAlpha(
                            opacityToAlpha(0.5),
                          ),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
