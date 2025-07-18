import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neom_commons/ui/theme/app_color.dart';
import 'package:neom_commons/ui/theme/app_theme.dart';
import 'package:neom_commons/ui/widgets/appbar_child.dart';
import 'package:neom_commons/ui/widgets/header_widget.dart';
import 'package:neom_commons/ui/widgets/title_subtitle_row.dart';
import 'package:neom_commons/utils/constants/translations/app_translation_constants.dart';
import 'package:neom_commons/utils/constants/translations/common_translation_constants.dart';
import 'package:neom_core/app_properties.dart';

import '../utils/constants/setting_translation_constants.dart';
import 'settings_controller.dart';

class AboutPage extends StatelessWidget {

  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (_) => Scaffold(
        backgroundColor: AppColor.main50,
        appBar: AppBarChild(title: CommonTranslationConstants.aboutApp.tr),
        body: Container(
          decoration: AppTheme.appBoxDecoration,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              HeaderWidget(
                SettingTranslationConstants.help.tr,
                secondHeader: true,
              ),
              TitleSubtitleRow(
                SettingTranslationConstants.helpCenter.tr,
                vPadding: 0,
                showDivider: false,
                url: AppProperties.getWebContact(),
              ),
              HeaderWidget(AppTranslationConstants.websites.tr),
              TitleSubtitleRow(
                  AppProperties.getAppName().tr,
                  showDivider: true,
                  url: AppProperties.getLandingPageUrl(),
              ),
              TitleSubtitleRow(
                SettingTranslationConstants.blog,
                showDivider: true,
                url: AppProperties.getBlogUrl(),
              ),
              HeaderWidget(SettingTranslationConstants.developer.tr),
              TitleSubtitleRow(
                  SettingTranslationConstants.github,
                  showDivider: true,
                  url: AppProperties.getDevGithub()
              ),
              TitleSubtitleRow(
                  SettingTranslationConstants.linkedin,
                  showDivider: true,
                  url: AppProperties.getDevLinkedIn()
              ),
            ],
          ),
        ),
      ),
    );
  }
}
