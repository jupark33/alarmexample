import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {

  final dailyNotiId = 3;

  static final NotificationService _notificationService = NotificationService._internal();
  
  factory NotificationService() {
    return _notificationService;
  }
  
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  
  NotificationService._internal();
  
  Future<void> initNotification() async {
    final AndroidInitializationSettings initializationSettingAndroid = AndroidInitializationSettings('@drawable/ic_flutter_noti');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingAndroid,
      iOS: initializationSettingsIOS
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(int id, String title, String body, int seconds) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'main_channel',
              'Main Channel',
            'Main Channel noti',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@drawable/ic_flutter_noti'
          ),
          iOS: IOSNotificationDetails(
            sound: 'default.wav',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          )
        ),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true
    );
  }

  /**
   * daily noti
   */
  Future<void> setDailyNoti(String title, String body, int seconds) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        dailyNotiId,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'main_channel',
                'Main Channel',
                'Main Channel noti',
                importance: Importance.max,
                priority: Priority.max,
                icon: '@drawable/ic_flutter_noti'
            ),
            iOS: IOSNotificationDetails(
              sound: 'default.wav',
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            )
        ),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,

    );
  }

  /**
   * daily noti
   */
  Future<void> setDailyNotiDt(String title, String body, DateTime dt) async {
    tz.TZDateTime tzDt = getNotiTime(dt);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      dailyNotiId,
      title,
      body,
      tzDt,
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'main_channel',
              'Main Channel',
              'Main Channel noti',
              importance: Importance.max,
              priority: Priority.max,
              icon: '@drawable/ic_flutter_noti'
          ),
          iOS: IOSNotificationDetails(
            sound: 'default.wav',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          )
      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,

    );
  }

  Future<void> cancelDailyNoti() async {
    await flutterLocalNotificationsPlugin.cancel(dailyNotiId);
  }

  tz.TZDateTime getNotiTime(DateTime dateTime) {
    tz.TZDateTime dt = tz.TZDateTime.now(tz.local);
    return tz.TZDateTime(tz.local, dt.year, dt.month, dt.day, dateTime.hour, dateTime.minute);
  }
}