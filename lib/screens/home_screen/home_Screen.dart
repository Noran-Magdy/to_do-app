// ignore_for_file: file_names

import 'package:calender_app/models/task_model.dart';
import 'package:calender_app/modules/buttons.dart';
import 'package:calender_app/screens/add_task_Screen/add_task_screen.dart';
import 'package:calender_app/shared/components/colors.dart';
import 'package:calender_app/modules/task_title.dart';
import 'package:calender_app/shared/components/text_style.dart';
import 'package:calender_app/shared/controllers/task_controller.dart';
import 'package:calender_app/shared/services/notification_service.dart';
import 'package:calender_app/shared/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var notifyHelper = NotifyHelper();
  DateTime selectedDate = DateTime.now();
  final taskControlller = Get.put(TaskController());

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
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          const SizedBox(
            height: 10,
          ),
          _showTaskes(),
        ],
      ),
    );
  }

  _showTaskes() {
    return Expanded(
      child: GetBuilder<TaskController>(
        builder: (_) {
          return ListView.builder(
            itemCount: _.taskList.length,
            itemBuilder: (context, index) {
              debugPrint('task length');
              debugPrint(_.taskList.length.toString());
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, _.taskList[index]);
                          },
                          child: TaskTile(
                            _.taskList[index],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  _bottomSheetButtons({
    required String label,
    required Function() onTap,
    required Color color,
    required BuildContext context,
    bool isClose = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: isClose ? Colors.transparent : color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : color,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? titleStyle()
                : titleStyle().copyWith(
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context, TaskModel task) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        color: Get.isDarkMode ? darkBackgroundColor : whiteColor,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
              ),
            ),
            const Spacer(),
            task.isCompleted == 1
                ? Container()
                : _bottomSheetButtons(
                    label: 'Task Completed',
                    onTap: () {
                      Get.back();
                    },
                    color: blueColor,
                    context: context,
                  ),
            _bottomSheetButtons(
              label: 'Delete Task',
              onTap: () {
                taskControlller.delete(task);
                taskControlller.getTasks();
                Get.back();
              },
              color: Colors.red[400]!,
              context: context,
            ),
            const SizedBox(
              height: 20,
            ),
            _bottomSheetButtons(
              label: 'Close',
              onTap: () {
                Get.back();
              },
              color: Colors.red[400]!,
              isClose: true,
              context: context,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
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
            onTap: () async {
              await Get.to(const AddTaskScreen());
              taskControlller.getTasks();
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
