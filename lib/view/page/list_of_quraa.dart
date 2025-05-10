import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/controller/list_of_quraa_ctrl.dart';
import 'package:quran_app/controller/theme_controller.dart';
import 'package:quran_app/view/widgets/custom_app_bar.dart';

class ListOfQuraa extends StatelessWidget {
  const ListOfQuraa({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    return ChangeNotifierProvider(
      create: (context) => ListOfQuraaCtrl(),
      child: Scaffold(
        backgroundColor: theme.primaryColor,
        appBar: customAppBar(theme: theme, title: "قائمة القراء"),
        body: Column(
          children: [CustomTextFormField(theme: theme, label: "اسم القارئ")],
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, this.label, required this.theme});
  final String? label;
  final ThemeController theme;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
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
