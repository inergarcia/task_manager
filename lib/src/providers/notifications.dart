import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsProvider with ChangeNotifier {
  late FlutterLocalNotificationsPlugin _flp;

  void init() {
    _flp = FlutterLocalNotificationsPlugin();
    var android = const AndroidInitializationSettings('@mipmap/launcher_icon');
    var iOS = const IOSInitializationSettings();
    var initSetttings = InitializationSettings(android: android, iOS: iOS);
    _flp.initialize(initSetttings);
    notifyListeners();
  }

  Future<void> showNotification(
      {required String title, required String msg}) async {
    var android = const AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.high, importance: Importance.max);
    var iOS = const IOSNotificationDetails();

    var platform = NotificationDetails(android: android, iOS: iOS);

    await _flp.show(0, title, msg, platform);
  }
}
