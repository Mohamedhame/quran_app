import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/controller/sound_play_ctrl.dart';
import 'package:quran_app/controller/theme_controller.dart';

class CustomShowSpeedAudioPage extends StatelessWidget {
  const CustomShowSpeedAudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        textDirection: TextDirection.rtl,
        children: [
          Text(
            "سرعة التشغيل",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<SoundPlayCtrl>(
                builder: (context, model, child) {
                  return GestureDetector(
                    onTapUp: (details) async {
                      double dx = details.globalPosition.dx;
                      double dy = details.globalPosition.dy;
                      double right = MediaQuery.of(context).size.width - dx;
                      double bottom = MediaQuery.of(context).size.width - dy;
                      showMenu(
                        color: theme.primaryColor,
                        context: context,
                        position: RelativeRect.fromLTRB(dx, dy, right, bottom),
                        items: [
                          ...List.generate(model.speedList.length, (index) {
                            String value = model.speedList[index].toString();
                            return PopupMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: theme.fontColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${model.speedList[index]}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "x",
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                model.setSpeed(model.speedList[index]);
                              },
                            );
                          }),
                        ],
                      );
                    },
                    child: Text(
                      model.speed.toStringAsFixed(2),
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
