import 'package:calender_app/modules/buttons.dart';
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
  int selectedRemind = 5;
  int selectedColor = 0;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];

  String selectedRepeat = 'None';
  List<String> repeatList = [
    'None',
    'Daily',
    'Weekly',
    'Monthly',
  ];

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
                InputField(
                  title: "Remind",
                  hint: "$selectedRemind minutes early",
                  widget: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    style: formFieldStyle(),
                    underline: Container(
                      height: 0,
                    ),
                    items:
                        remindList.map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text('$value'),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedRemind = int.parse(value!);
                        debugPrint(selectedRemind.toString());
                      });
                    },
                  ),
                ),
                InputField(
                  title: "Repeat",
                  hint: selectedRepeat,
                  widget: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    style: formFieldStyle(),
                    underline: Container(
                      height: 0,
                    ),
                    items: repeatList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedRepeat = value!;
                        debugPrint(selectedRemind.toString());
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 18,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _colorPallete(),
                      DefaultButtons(
                        label: 'Create Task',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: titleStyle(),
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          children: List<Widget>.generate(
            3,
            (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColor = index;
                    debugPrint(selectedColor.toString());
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 8.0,
                  ),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? blueColor
                        : index == 1
                            ? pinkColor
                            : yellowColor,
                    child: selectedColor == index
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 16,
                          )
                        : Container(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
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

  _getTimeFromUser({required bool isStartTime}) {
    showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        //started time >> 10:30 AM
        hour: int.parse(startTime.split(':')[0]),
        minute: int.parse(startTime.split(":")[1].split(' ')[0]),
      ),
    ).then((value) {
      debugPrint(value.toString());
      String? _formatedTime = value?.format(context);
      debugPrint(" formatedTime $_formatedTime");
      if (isStartTime == true) {
        debugPrint(_formatedTime);
        setState(() {
          startTime = _formatedTime!;
        });
      } else if (isStartTime == false) {
        debugPrint(_formatedTime);
        setState(() {
          endTime = _formatedTime!;
        });
      }
    });
  }
}
