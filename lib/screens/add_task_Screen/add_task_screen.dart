import 'package:calender_app/modules/input_field.dart';
import 'package:calender_app/shared/components/colors.dart';
import 'package:calender_app/shared/components/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = '9:30 PM';
  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: _defaultAppBar(),
        body: Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Task',
                  style: headerStyle(),
                ),
                const InputField(
                  title: 'Title',
                  hint: 'Enter your title',
                ),
                const InputField(
                  title: 'Note',
                  hint: 'Enter your note',
                ),
                InputField(
                  title: 'Date',
                  hint: DateFormat.yMd().format(selectedDate),
                  widget: IconButton(
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      debugPrint('tapped');
                      _getDateFromUser();
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        title: 'Start Time',
                        hint: startTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(
                              isStartTime: true,
                            );
                          },
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: InputField(
                        title: 'End Time',
                        hint: endTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(
                              isStartTime: false,
                            );
                          },
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _defaultAppBar() {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios_new,
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

  _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2024),
    );
    if (_pickedDate != null) {
      setState(() {
        selectedDate = _pickedDate;
      });
    } else {
      debugPrint('something wrong');
    }
  }

  _getTimeFromUser({bool? isStartTime}) {
    var _pickedTime = _showTimePicker();
    String _formatedTime = _pickedTime.formate();
    if (_pickedTime == null) {
      debugPrint('something wrong');
    } else if (isStartTime == true) {
      setState(() {
        startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: const TimeOfDay(
        hour: 9,
        minute: 10,
      ),
    );
  }
}
