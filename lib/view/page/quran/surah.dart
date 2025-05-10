import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/controller/sound_play_ctrl.dart';
import 'package:quran_app/controller/surah_ctrl.dart';
import 'package:quran_app/controller/theme_controller.dart';
import 'package:quran_app/view/page/sound_play.dart';
import 'package:quran_app/view/widgets/custom_app_bar.dart';
import 'package:quran_app/view/widgets/custom_download_or_check_icon_and_paly_icon.dart';
import 'package:quran_app/view/widgets/custom_item_in_list_view.dart';

class Surah extends StatelessWidget {
  const Surah({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    final model = Provider.of<SurahCtrl>(context);
    final soundPlay = Provider.of<SoundPlayCtrl>(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: customAppBar(theme: theme, title: model.shikhName),
      body:
          model.isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: model.surahs.length,
                itemBuilder: (context, index) {
                  return CustomItemInListView(
                    theme: theme,
                    titleItem: model.surahs[index]['name'],
                    widget: CustomDownloadOrCheckIconAndPalyIcon(
                      theme: theme,
                      data: model.surahs,
                      index: index,
                      dir: model.shikhName,
                    ),

                    onTap: () {
                      soundPlay.playAudio(
                        model.surahs,
                        index,
                        shihkName: model.shikhName,
                      );
                      soundPlay.handlePlayPause();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => SoundPlay(
                                sikhName: model.shikhName,
                                isSerah: false,
                                data: model.surahs,
                                index: index,
                              ),
                        ),
                      );
                    },
                  );
                },
              ),
    );
  }
}
