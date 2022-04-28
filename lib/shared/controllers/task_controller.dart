// ignore_for_file: avoid_print

import 'package:calender_app/models/task_model.dart';
import 'package:calender_app/shared/database/db_helper.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  var taskList = <TaskModel>[];

  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

//add task data to table
  Future<int> addTask({TaskModel? task}) async {
    print('convert data to task model');
    return await DBHelper.insert(task!);
  }

//get data from table
  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => TaskModel.fromJson(data)).toList());
    update();
  }
}
