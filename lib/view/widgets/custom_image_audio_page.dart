import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/controller/sound_play_ctrl.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.isSira, required this.sikhName});
  final bool isSira;

  final String sikhName;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          height: isSira ? size.height * 0.28 : size.height * 0.35,
          width: 300,
          decoration: BoxDecoration(shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Image.asset(
            isSira ? "assets/images/sira.png" : "assets/images/quran.jpg",
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10),
        Selector<SoundPlayCtrl, String>(
          builder: (context, value, child) {
            return Text(
              textAlign: TextAlign.center,
              value,
              style: GoogleFonts.amiri(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            );
          },
          selector: (_, ctrl) => ctrl.title!,
        ),
        Text(
          textAlign: TextAlign.center,
          sikhName,
          style: GoogleFonts.amiri(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
