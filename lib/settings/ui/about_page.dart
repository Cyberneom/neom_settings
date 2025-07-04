import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neom_commons/commons/ui/theme/app_color.dart';
import 'package:neom_commons/commons/ui/theme/app_theme.dart';
import 'package:neom_commons/commons/ui/widgets/appbar_child.dart';
import 'package:neom_commons/commons/ui/widgets/header_widget.dart';
import 'package:neom_commons/commons/ui/widgets/title_subtitle_row.dart';
import 'package:neom_commons/commons/utils/constants/app_translation_constants.dart';
import 'package:neom_core/core/app_properties.dart';

import 'settings_controller.dart';

class AboutPage extends StatelessWidget {

  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (_) => Scaffold(
        backgroundColor: AppColor.main50,
        appBar: AppBarChild(title: AppTranslationConstants.aboutApp.tr),
        body: Container(
          decoration: AppTheme.appBoxDecoration,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              HeaderWidget(
                AppTranslationConstants.help.tr,
                secondHeader: true,
              ),
              TitleSubtitleRow(
                AppTranslationConstants.helpCenter.tr,
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
                  AppTranslationConstants.blog,
                  showDivider: true,
                  url: AppProperties.getBlogUrl(),
              ),
              HeaderWidget(AppTranslationConstants.developer.tr),
              TitleSubtitleRow(
                AppTranslationConstants.github,
                showDivider: true,
                url: AppProperties.getDevGithub()
              ),
              TitleSubtitleRow(
                AppTranslationConstants.linkedin,
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
