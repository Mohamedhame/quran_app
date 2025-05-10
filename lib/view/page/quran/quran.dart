import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/controller/theme_controller.dart';
import 'package:quran_app/utilities/routes.dart';
import 'package:quran_app/view/widgets/custom_button.dart';
import 'package:quran_app/view/widgets/stylish_card.dart';

class Quran extends StatelessWidget {
  const Quran({super.key});

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
