import 'package:calender_app/shared/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifiedScreen extends StatelessWidget {
  final String? label;
  const NotifiedScreen({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.grey[600] : Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Get.isDarkMode ? whiteColor : Colors.grey,
          onPressed: () => Get.back(),
        ),
        title: Text(
          label.toString().split('|')[0],
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
