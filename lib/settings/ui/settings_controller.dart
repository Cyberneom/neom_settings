import 'package:enum_to_string/enum_to_string.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:neom_commons/analytics/data/firestore/app_analytics_firestore.dart';
import 'package:neom_commons/commons/app_flavour.dart';
import 'package:neom_commons/commons/utils/app_utilities.dart';
import 'package:neom_commons/commons/utils/constants/app_locale_constants.dart';
import 'package:neom_commons/commons/utils/constants/app_page_id_constants.dart';
import 'package:neom_commons/commons/utils/constants/app_translation_constants.dart';
import 'package:neom_core/core/app_config.dart';
import 'package:neom_core/core/data/implementations/app_hive_controller.dart';
import 'package:neom_core/core/data/implementations/geolocator_controller.dart';
import 'package:neom_core/core/data/implementations/user_controller.dart';
import 'package:neom_core/core/domain/use_cases/login_service.dart';
import 'package:neom_core/core/utils/enums/app_in_use.dart';
import 'package:neom_core/core/utils/enums/app_locale.dart';
import 'package:neom_jobs/jobs/jobs_firestore.dart';

import '../domain/use_cases/settings_service.dart';

class SettingsController extends GetxController implements SettingsService {

  var logger = AppConfig.logger;
  final loginController = Get.find<LoginService>();
  final userController = Get.find<UserController>();

  final RxBool isLoading = true.obs;
  final RxString newLanguage = "".obs;
  final Rx<AppLocale> appLocale = AppLocale.english.obs;
  final Rx<LocationPermission> locationPermission = LocationPermission.whileInUse.obs;

  @override
  void onInit() async {
    super.onInit();
    logger.d("Settings Controller Init");
    await userController.getProfiles();
    newLanguage.value = AppLocaleConstants.languageFromLocale(Get.locale!);
    isLoading.value = false;
    locationPermission.value = await Geolocator.checkPermission();
  }

  @override
  void setNewLanguage(String newLang){
    logger.d("Setting new language as $newLang");
    newLanguage.value = newLang;
    update([AppPageIdConstants.settingsPrivacy]);
  }

  @override
  void setNewLocale(){
    logger.d("Setting new locale");
    appLocale.value = EnumToString.fromString(AppLocale.values, newLanguage.value)!;
    bool isAvailable = false;
    Get.back();

    switch(appLocale.value){
      case AppLocale.spanish:
        isAvailable = true;
        break;
      case AppLocale.english:
      case AppLocale.french:
        if(AppFlavour.appInUse == AppInUse.g) isAvailable = true;
        break;
      case AppLocale.deutsch:
        break;
    }

    try {
      if(isAvailable) {
        AppHiveController().setLocale(appLocale.value);
        AppHiveController().updateLocale(appLocale.value);
      } else {
        AppUtilities.showSnackBar(
          title: AppTranslationConstants.underConstruction.tr,
          message: AppTranslationConstants.underConstructionMsg.tr,
        );
      }
    } catch (e) {
      logger.e(e.toString());
    }

    update([AppPageIdConstants.settingsPrivacy]);
  }

  @override
  Future<void> verifyLocationPermission() async {
    logger.d("Verifying and requesting location permission");
    locationPermission.value = await GeoLocatorController().requestPermission();
    update([AppPageIdConstants.settingsPrivacy]);
  }

  @override
  Future<void> runAnalyticJobs() async {
    isLoading.value = true;
    update([AppPageIdConstants.settingsPrivacy]);

    try {
      await AppAnalyticsFirestore().setUserLocations();
    } catch(e) {
      AppConfig.logger.e(e.toString());
    }

    isLoading.value = false;
    logger.d("Analytic Job successfully ran.");
    update([AppPageIdConstants.settingsPrivacy]);
  }

  @override
  Future<void> runProfileJobs() async {
    isLoading.value = true;
    update([AppPageIdConstants.settingsPrivacy]);

    try {
      await JobsFirestore().createProfileInstrumentsCollection();
    } catch(e) {
      AppConfig.logger.e(e.toString());
    }

    isLoading.value = false;
    logger.d("Profile Job successfully ran.");
    update([AppPageIdConstants.settingsPrivacy]);
  }

}
