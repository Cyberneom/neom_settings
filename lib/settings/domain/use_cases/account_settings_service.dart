import 'package:flutter/material.dart';

abstract class AccountSettingsService {

  void getSubscriptionAlert(BuildContext context);
  Future<void> updatePhone(BuildContext context);
  Future<bool?> getUpdatePhoneAlert(BuildContext context);
  Widget buildPhoneField();

}
