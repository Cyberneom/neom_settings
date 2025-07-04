import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:neom_commons/commons/app_flavour.dart';
import 'package:neom_commons/commons/ui/theme/app_color.dart';
import 'package:neom_commons/commons/ui/theme/app_theme.dart';
import 'package:neom_commons/commons/ui/widgets/app_circular_progress_indicator.dart';
import 'package:neom_commons/commons/ui/widgets/appbar_child.dart';
import 'package:neom_commons/commons/ui/widgets/header_widget.dart';
import 'package:neom_commons/commons/ui/widgets/title_subtitle_row.dart';
import 'package:neom_commons/commons/utils/constants/app_page_id_constants.dart';
import 'package:neom_commons/commons/utils/constants/app_translation_constants.dart';
import 'package:neom_commons/commons/utils/external_utilities.dart';
import 'package:neom_core/core/app_properties.dart';
import 'package:neom_core/core/utils/constants/app_route_constants.dart';
import 'package:neom_core/core/utils/enums/app_in_use.dart';
import 'package:neom_core/core/utils/enums/user_role.dart';
import 'package:url_launcher/url_launcher.dart';

import 'settings_controller.dart';

class SettingsPrivacyPage extends StatelessWidget {

  const SettingsPrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      id: AppPageIdConstants.settingsPrivacy,
      init: SettingsController(),
      builder: (_) => Scaffold(
        appBar: AppBarChild(title: AppTranslationConstants.settingsPrivacy.tr),
        backgroundColor: AppColor.main50,
        body: Obx(()=>Container(
          decoration: AppTheme.appBoxDecoration,
          child: _.isLoading.value ? Container(
              decoration: AppTheme.appBoxDecoration,
              child: const AppCircularProgressIndicator()) :
          ListView(
          children: <Widget>[
            HeaderWidget(_.userController.user.name.capitalize),
            TitleSubtitleRow(AppTranslationConstants.account.tr, navigateTo: AppRouteConstants.settingsAccount),
            TitleSubtitleRow(AppTranslationConstants.privacyAndPolicy.tr, navigateTo: AppRouteConstants.privacyAndTerms),
            TitleSubtitleRow(AppTranslationConstants.contentPreferences.tr, navigateTo: AppRouteConstants.contentPreferences),
            HeaderWidget(AppTranslationConstants.general.tr.capitalize, secondHeader: true,),
            TitleSubtitleRow(AppTranslationConstants.aboutApp.tr, navigateTo: AppRouteConstants.about),
            // if(AppFlavour.appInUse == AppInUse.c) TitleSubtitleRow(AppTranslationConstants.likeMyWork.tr, subtitle: AppTranslationConstants.buyCoffee.tr,
            //   onPressed: () => launchUrl(Uri.parse(AppFlavour.getBuyMeACoffeeURL(),),)),
            TitleSubtitleRow(AppTranslationConstants.contactUs.tr, subtitle: AppTranslationConstants.contactUsSub.tr,
                onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 100,
                      child: Container(
                        decoration: AppTheme.appBoxDecoration75,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(FontAwesomeIcons.envelope,),
                                  iconSize: 40,
                                  tooltip: AppTranslationConstants.gmail.tr,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    final email = Uri.encodeFull(AppProperties.getEmail());
                                    final subject = Uri.encodeFull('Regarding Mobile App');
                                    final uri = Uri.parse(
                                      'mailto:$email?subject=$subject',
                                    );
                                    launchUrl(uri,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  },
                                ),
                                Text(AppTranslationConstants.gmail.tr,),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(FontAwesomeIcons.whatsapp,),
                                  iconSize: 40,
                                  tooltip: AppTranslationConstants.whatsContact.tr,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    ExternalUtilities.launchWhatsappURL(AppProperties.getWhatsappBusinessNumber(), AppTranslationConstants.hello.tr);
                                  },
                                ),
                                Text(AppTranslationConstants.whatsapp.tr,),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(FontAwesomeIcons.instagram,),
                                  iconSize: 40,
                                  tooltip: AppTranslationConstants.instagram.tr,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    launchUrl(Uri.parse(AppProperties.getInstagram(),),
                                      mode: LaunchMode.externalApplication,
                                    );
                                  },
                                ),
                                Text(
                                  AppTranslationConstants.insta.tr,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            if(AppFlavour.appInUse != AppInUse.c) TitleSubtitleRow(AppTranslationConstants.joinWhats.tr, subtitle: AppTranslationConstants.joinWhatsSub.tr,
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 100,
                      child: Container(
                        decoration: AppTheme.appBoxDecoration75,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(FontAwesomeIcons.whatsapp,),
                                  iconSize: 40,
                                  tooltip: AppTranslationConstants.whatsCommunity.tr,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    launchUrl(Uri.parse(AppProperties.getMainWhatsGroupUrl()),
                                      mode: LaunchMode.externalApplication,
                                    );
                                  },
                                ),
                                Text(
                                  AppTranslationConstants.whatsRock.tr,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(FontAwesomeIcons.whatsapp,),
                                  iconSize: 40,
                                  tooltip: AppTranslationConstants.whatsCommunity.tr,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    launchUrl(Uri.parse(AppProperties.getSecondaryWhatsGroupUrl()),
                                      mode: LaunchMode.externalApplication,
                                    );
                                  },
                                ),
                                Text(
                                  AppTranslationConstants.whatsCommunity.tr,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            //TODO
            if(_.userController.user.userRole != UserRole.subscriber)
            Column(
              children: [
                HeaderWidget(AppTranslationConstants.adminCenter.tr, secondHeader: true),
                TitleSubtitleRow(AppTranslationConstants.createCoupon.tr, navigateTo: AppRouteConstants.createCoupon),
                TitleSubtitleRow(AppTranslationConstants.createSponsor.tr, navigateTo: AppRouteConstants.createSponsor),
                TitleSubtitleRow(AppTranslationConstants.usersDirectory.tr, navigateTo: AppRouteConstants.directory, navigateArguments: const [true],),
                TitleSubtitleRow(AppTranslationConstants.seeAnalytics.tr, navigateTo: AppRouteConstants.analytics),
                if(_.userController.user.userRole == UserRole.superAdmin)
                  Column(
                    children: [
                      TitleSubtitleRow(AppTranslationConstants.runAnalyticsJobs.tr, onPressed: _.runAnalyticJobs),
                      TitleSubtitleRow(AppTranslationConstants.runProfileJobs.tr, onPressed: _.runProfileJobs),
                  ],),
              ],
            ),
            TitleSubtitleRow("", showDivider: false, vPadding: 10, subtitle: AppTranslationConstants.settingPrivacyMsg.tr),
          ],
        ),
        ),),
    ),);
  }
}
