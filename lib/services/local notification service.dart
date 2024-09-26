import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  LocalNotificationService._();

  static LocalNotificationService notificationService =
      LocalNotificationService._();

  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  //init

  Future<void> initNotificationService() async {
    plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    AndroidInitializationSettings android =
        AndroidInitializationSettings('mipmap/ic_launcher');
    DarwinInitializationSettings iOS = DarwinInitializationSettings();
    InitializationSettings setting = InitializationSettings(
      android: android,
      iOS: iOS,
    );

    await plugin.initialize(setting);
  }

  //SHOW
  Future<void> showNotification(String title,String body) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'chat-app',
      'Local Notification',
      importance: Importance.max,
      priority: Priority.max,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );
    
    await plugin.show(0, title, body , notificationDetails);
  }
}
