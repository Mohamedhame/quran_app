import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/controller/theme_controller.dart';
import 'package:quran_app/utilities/routes.dart';
import 'package:quran_app/view/widgets/custom_button.dart';
import 'package:quran_app/view/widgets/stylish_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      theme.toggleTheme();
                    },
                    child: Icon(
                      theme.isLight ? Icons.light_mode : Icons.dark_mode,
                      color: theme.fontColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 70),
                    const StylishCard(
                      title:
                          'عن أبي أُمَامَةَ البَاهِلِي رضي الله عنه قال: سمعتُ رسولَ اللهِ صلَّى اللهُ عليهِ وسلَّمَ يقول: ',
                      body:
                          '"اقْرَؤُوا القُرآنَ، فإنَّهُ يأتي يومَ القيامةِ شفيعًا لأصحابِه"... رواه مسلم.',
                      footer: 'فإن غلبتَ على قراءته، فلا تُغلب على سماعه.',
                    ),
                    const SizedBox(height: 70),
                    CustomButton(
                      textButton: "تلاوة",
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.readQuran);
                      },
                    ),
                    CustomButton(
                      textButton: "سماع",
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.listOfQurra);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
