import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/controller/sira_ctrl.dart';
import 'package:quran_app/controller/theme_controller.dart';
import 'package:quran_app/view/widgets/custom_app_bar.dart';
import 'package:quran_app/view/widgets/custom_download_or_check_icon_and_paly_icon.dart';
import 'package:quran_app/view/widgets/custom_item_in_list_view.dart';

class Sira extends StatelessWidget {
  const Sira({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    final model = Provider.of<SiraCtrl>(context);
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
                      isExit: model.siraData[index]['isExit'],
                    ),
                  );
                },
              ),
    );
  }
}
