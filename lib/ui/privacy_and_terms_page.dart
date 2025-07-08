import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neom_commons/ui/theme/app_color.dart';
import 'package:neom_commons/ui/theme/app_theme.dart';
import 'package:neom_commons/ui/widgets/appbar_child.dart';
import 'package:neom_commons/ui/widgets/header_widget.dart';
import 'package:neom_commons/ui/widgets/title_subtitle_row.dart';
import 'package:neom_commons/utils/constants/app_translation_constants.dart';
import 'package:neom_core/app_config.dart';
import 'package:neom_core/app_properties.dart';

import 'settings_controller.dart';

class PrivacyAndTermsPage extends StatelessWidget {

  const PrivacyAndTermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (_) => Scaffold(
        backgroundColor: AppColor.main50,
        appBar: AppBarChild(title: AppTranslationConstants.privacyAndPolicy.tr),
        body: Container(
          decoration: AppTheme.appBoxDecoration,
          child: Column(
            children: <Widget>[
              HeaderWidget(AppTranslationConstants.legal.tr),
              TitleSubtitleRow(
                AppTranslationConstants.termsOfService.tr,
                showDivider: true,
                url: AppProperties.getTermsOfServiceUrl(),
              ),
              TitleSubtitleRow(
                AppTranslationConstants.privacyPolicy.tr,
                showDivider: true,
                url: AppProperties.getPrivacyPolicyUrl(),
              ),
              TitleSubtitleRow(
                AppTranslationConstants.legalNotices.tr,
                showDivider: true,
                onPressed: () =>
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => Theme(
                          data: ThemeData(
                            brightness: Brightness.dark,
                            fontFamily: AppTheme.fontFamily,
                            cardColor: AppColor.main50,
                          ),
                          child: LicensePage(
                            applicationVersion: AppConfig.instance.appVersion,
                            applicationName: AppProperties.getAppName(),
                          ),
                        ),
                      ),
                    )

              ),
            ],
          ),
        ),
      ),
    );
  }
}
