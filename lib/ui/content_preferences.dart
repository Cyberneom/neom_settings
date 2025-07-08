import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:neom_commons/ui/theme/app_color.dart';
import 'package:neom_commons/ui/theme/app_theme.dart';
import 'package:neom_commons/ui/widgets/appbar_child.dart';
import 'package:neom_commons/ui/widgets/header_widget.dart';
import 'package:neom_commons/ui/widgets/title_subtitle_row.dart';
import 'package:neom_commons/utils/app_alerts.dart';
import 'package:neom_commons/utils/constants/app_locale_constants.dart';
import 'package:neom_commons/utils/constants/app_page_id_constants.dart';
import 'package:neom_commons/utils/constants/app_translation_constants.dart';
import 'package:neom_core/utils/constants/app_route_constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'settings_controller.dart';

class ContentPreferencePage extends StatelessWidget {

  const ContentPreferencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      id: AppPageIdConstants.settingsPrivacy,
      builder: (_) => Scaffold(
        appBar: AppBarChild(title: AppTranslationConstants.contentPreferences.tr),
        backgroundColor: AppColor.main50,
        body: Container(
        decoration: AppTheme.appBoxDecoration,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            HeaderWidget(AppTranslationConstants.language.tr, secondHeader: true),
            TitleSubtitleRow(
                AppTranslationConstants.preferredLanguage.tr,
                subtitle: AppLocaleConstants.languageFromLocale(Get.locale!).tr,
                onPressed: () => Alert(
                  context: context,
                  style: AlertStyle(
                      backgroundColor: AppColor.main50,
                      titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                  ),
                  title: AppTranslationConstants.chooseYourLanguage.tr,
                  content: Obx(()=> DropdownButton<String>(
                        items: AppLocaleConstants.supportedLanguages.map<DropdownMenuItem<String>>((String language) {
                          return DropdownMenuItem<String>(
                              value: language,
                              child: Text(language.tr)
                          );
                        }).toList(),
                        onChanged: (String? selectedLanguage) {
                          _.setNewLanguage(selectedLanguage!);
                        },
                        value: _.newLanguage.value,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: AppColor.main75,
                        underline: Container(
                            height: 1,
                            color: Colors.grey
                        ),
                      ),
                  ),
                  buttons: [
                    DialogButton(
                      color: AppColor.bondiBlue75,
                      onPressed: () => {
                        _.setNewLocale()
                      },
                      child: Text(AppTranslationConstants.setLocale.tr,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ).show()
            ),
            HeaderWidget(AppTranslationConstants.safety.tr, secondHeader: true),
            TitleSubtitleRow('${AppTranslationConstants.locationUsage.tr}: ${_.locationPermission.value.name.tr}',
              onPressed: () async {
                //Get.toNamed(GigRouteConstants.INTRO_REQUIRED_PERMISSIONS);
                _.locationPermission.value == LocationPermission.denied ?
                  await _.verifyLocationPermission()
                  : AppAlerts.showAlert(context, title: AppTranslationConstants.locationUsage.tr,
                    message: AppTranslationConstants.changeThisInTheAppSettings.tr.tr);
              }
            ),
            TitleSubtitleRow(AppTranslationConstants.blockedProfiles.tr,
              onPressed: () => _.userController.profile.blockTo!.isNotEmpty
                  ? Get.toNamed(AppRouteConstants.blockedProfiles, arguments: _.userController.profile.blockTo)
                  : AppAlerts.showAlert(context, title: AppTranslationConstants.blockedProfiles.tr,
                      message: AppTranslationConstants.blockedProfilesMsg.tr),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
