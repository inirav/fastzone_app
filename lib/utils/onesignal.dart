import 'dart:io';
import 'package:fastzone/data/appkeys.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/foundation.dart';

Future<void> setupOneSignal() async {
  // Will work only in debug builds.
  if (kDebugMode) {
    OneSignal.shared.setLogLevel(OSLogLevel.warn, OSLogLevel.warn);
  }

  await OneSignal.shared.setAppId(AppKey.oneSignalId);

  OneSignal.shared.consentGranted(true);
  if (Platform.isIOS) {
    OneSignal.shared.promptUserForPushNotificationPermission();
  }

  var data = await OneSignal.shared.getDeviceState();
  debugPrint("CURRENT USER ONESIGNAL ID => ${data!.userId}");

  // OneSignal.shared
  //     .setInFocusDisplayType(OSNotificationDisplayType.notification);

  // OneSignal.shared
  //     .setNotificationReceivedHandler((OSNotification notification) {
  //   // will be called whenever a notification is received
  //   debugPrint("setNotificationReceivedHandler");
  // });

  OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    // will be called whenever a notification is opened/button pressed.
    debugPrint("setNotificationOpenedHandler");
  });

  OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    // will be called whenever the permission changes
    // (ie. user taps Allow on the permission prompt in iOS)
    debugPrint("setPermissionObserver");
  });

  OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) {
    // will be called whenever the subscription changes
    debugPrint("setSubscriptionObserver");
    //(ie. user gets registered with OneSignal and gets a user ID)
  });

  OneSignal.shared.setEmailSubscriptionObserver((OSEmailSubscriptionStateChanges emailChanges) {
    // will be called whenever then user's email subscription changes
    // (ie. OneSignal.setEmail(email) is called and the user gets registered
    debugPrint("setEmailSubscriptionObserver");
  });
}