// ignore_for_file: file_names

import 'package:calender_app/modules/buttons.dart';
import 'package:calender_app/screens/add_task_Screen/add_task_screen.dart';
import 'package:calender_app/shared/components/colors.dart';
import 'package:calender_app/shared/components/text_style.dart';
import 'package:calender_app/shared/services/notification_service.dart';
import 'package:calender_app/shared/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var notifyHelper = NotifyHelper();
  DateTime selectedDate = DateTime.now();

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
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
        ],
      ),
    );
  }

  _addDateBar() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
      ),
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        height: 100,
        width: 80,
        selectionColor: blueColor,
        selectedTextColor: whiteColor,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey[500],
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.grey[500],
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.grey[500],
          ),
        ),
        onDateChange: (date) {
          selectedDate = date;
          debugPrint(selectedDate.toIso8601String());
        },
      ),
    );
  }

  _addTaskBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeaderStyle(
                  color: Get.isDarkMode ? Colors.grey[400] : Colors.grey,
                ),
              ),
              Text(
                'Today',
                style: headerStyle(
                  color: Get.isDarkMode ? whiteColor : darkBackgroundColor,
                ),
              ),
            ],
          ),
          DefaultButtons(
            label: ' + Add Task',
            onTap: () {
              Get.to(const AddTaskScreen());
            },
          ),
        ],
      ),
    );
  }

  _defaultAppBar() {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
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
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_rounded : Icons.nightlight_round,
          size: 22,
          color: Get.isDarkMode ? whiteColor : darkBackgroundColor,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: NetworkImage(
            'https://image.shutterstock.com/image-illustration/male-user-icon-isolated-on-260nw-405711598.jpg',
          ),
          radius: 22,
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
