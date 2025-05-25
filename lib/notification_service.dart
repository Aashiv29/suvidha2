import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
    InitializationSettings(android: androidSettings);

    await _notificationsPlugin.initialize(settings);
  }

  static Future<void> scheduleNotification(
      int id, DateTime scheduledTime, String medicineName) async {
    await _notificationsPlugin.zonedSchedule(
      id, // Unique ID for each reminder
      'Medicine Reminder',
      'Time to take your $medicineName',
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'medicine_reminder',
          'Medicine Reminder',
          channelDescription: 'Reminds you to take medicine',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
        ),
      ),
      // androidAllowWhileIdle: true,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
  
  static Future<void> scheduleRepeatingNotification(
      int id, DateTime firstTime, List<int> repeatDays, String medicineName) async {
    for (int day in repeatDays) {
      DateTime nextReminder = firstTime.add(Duration(days: (day - firstTime.weekday) % 7));
      await _notificationsPlugin.zonedSchedule(
        id + day, // Unique ID for each scheduled day
        'Medicine Reminder',
        'Time to take your $medicineName',
        tz.TZDateTime.from(nextReminder, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'medicine_reminder',
            'Medicine Reminder',
            channelDescription: 'Scheduled medicine reminders',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
          ),
        ),
        // androidAllowWhileIdle: true,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  static Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }
}
