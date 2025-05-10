import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/controller/list_of_quraa_ctrl.dart';
import 'package:quran_app/controller/surah_ctrl.dart';
import 'package:quran_app/controller/theme_controller.dart';
import 'package:quran_app/view/page/quran/surah.dart';
import 'package:quran_app/view/widgets/custom_app_bar.dart';
import 'package:quran_app/view/widgets/custom_item_in_list_view.dart';
import 'package:quran_app/view/widgets/custom_text_form_filed.dart';

class ListOfQuraa extends StatelessWidget {
  const ListOfQuraa({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    final model = Provider.of<ListOfQuraaCtrl>(context);
    List data = model.filterQuraaOnSearch;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: customAppBar(theme: theme, title: "قائمة القراء"),
      body: Column(
        children: [
          CustomTextFormField(
            theme: theme,
            label: "اسم القارئ",
            onChanged: model.runFilterData,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                String shikhName = data[index]['name'];
                String url = data[index]['url'];
                return CustomItemInListView(
                  theme: theme,
                  titleItem: shikhName,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (context) => ChangeNotifierProvider(
                              create:
                                  (context) =>
                                      SurahCtrl(shikhName: shikhName, url: url),
                              child: Surah(),
                            ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
