import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/controller/sira_ctrl.dart';
import 'package:quran_app/controller/sound_play_ctrl.dart';
import 'package:quran_app/controller/theme_controller.dart';
import 'package:quran_app/view/page/sound_play.dart';
import 'package:quran_app/view/widgets/custom_app_bar.dart';
import 'package:quran_app/view/widgets/custom_download_or_check_icon_and_paly_icon.dart';
import 'package:quran_app/view/widgets/custom_item_in_list_view.dart';

class Sira extends StatelessWidget {
  const Sira({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    final soundPlay = Provider.of<SoundPlayCtrl>(context);
    return ChangeNotifierProvider(
      create: (context) => SiraCtrl()..goToAudio(context, soundPlay),
      child: Consumer<SiraCtrl>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: theme.primaryColor,
            appBar: customAppBar(theme: theme, title: "السيره النبوية"),
            body:
                model.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      itemCount: model.siraData.length,
                      itemBuilder: (context, index) {
                        return CustomItemInListView(
                          theme: theme,
                          titleItem: model.siraData[index]['name'],
                          widget: CustomDownloadOrCheckIconAndPalyIcon(
                            theme: theme,
                            data: model.siraData,
                            index: index,
                            dir: "الدكتور راغب السرجاني",
                          ),

                          onTap: () {
                            soundPlay.playAudio(
                              model.siraData,
                              index,
                              shikhName: "الدكتور راغب السرجاني",
                            );
                            soundPlay.handlePlayPause();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (context) => SoundPlay(
                                      sikhName: "الدكتور راغب السرجاني",
                                      isSerah: true,
                                      data: model.siraData,
                                      index: index,
                                    ),
                              ),
                            );
                          },
                        );
                      },
                    ),
          );
        },
      ),
    );
  }
}
