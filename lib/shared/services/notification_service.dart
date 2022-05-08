import 'package:calender_app/models/task_model.dart';
import 'package:calender_app/screens/notified_screen/notified_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //

  initializeNotification() async {
    _configureLocalTimeZone();
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("appicon");

    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: selectNotification,
    );
  }

  cancelNotification(TaskModel task) async {
    debugPrint('cancel notification success');
    await flutterLocalNotificationsPlugin.cancel(task.id!);
  }

  displayNotification({required String title, required String body}) async {
    debugPrint("doing test");
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high);
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: title,
    );
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    debugPrint('doone');
  }

  scheduledNotification(int hour, int minutes, TaskModel task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!.toInt(),
      task.title,
      task.note,
      _convertTime(hour, minutes),
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
          android: AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        channelDescription: 'your channel description',
      )),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: "${task.title}| + ${task.note} |",
    );
  }

  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    debugPrint('scheduleTime is $scheduleDate');
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    debugPrint('timeZone is $timeZone');
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    } else {
      debugPrint("Notification Done");
    }
    if (payload == 'Theme Changed') {
      debugPrint('nothing navigate to');
    } else {
      Get.to(() => NotifiedScreen(
            label: payload,
          ));
    }
  }

  Future onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    Get.dialog(
      const Text('Welcome To Flutter'),
    );
  }
}
