// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:calender_app/modules/home_screen/body.dart';
import 'package:calender_app/shared/services/notification_service.dart';
import 'package:calender_app/shared/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    // NotifyHelper().requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _defaultAppBar(),
      body: const HomeScreenBody(),
    );
  }

  _defaultAppBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
            title: "Theme Changed",
            body: !Get.isDarkMode
                ? "Activated Dark Theme"
                : "Activated Light Theme",
          );
          debugPrint('tapped');
        },
        child: const Icon(
          Icons.nightlight_round,
          size: 22,
        ),
      ),
      actions: const [
        Icon(
          Icons.person,
          size: 22,
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
