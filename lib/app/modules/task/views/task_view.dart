import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:task_management_app/app/utils/style/AppColors.dart';
import 'package:task_management_app/app/utils/widget/header.dart';

import 'package:task_management_app/app/utils/widget/sideBar.dart';
import '../controllers/task_controller.dart';

class TaskView extends GetView<TaskController> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: const SizedBox(width: 150, child: const SideBar()),
      backgroundColor: AppColors.primaryBg,
      body: SafeArea(
        child: Row(
          children: [
            !context.isPhone
                ? const Expanded(
                    flex: 2,
                    child: SideBar(),
                  )
                : const SizedBox(),
            Expanded(
                flex: 15,
                child: Column(
                  children: [
                    !context.isPhone
                        ? const header()
                        : Container(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _drawerKey.currentState!.openDrawer();
                                  },
                                  icon: const Icon(
                                    Icons.menu,
                                    color: AppColors.primaryText,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Task Management',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: AppColors.primaryText),
                                    ),
                                    Text(
                                      'Manage Task made easy with friends',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.primaryText),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                const Icon(
                                  Ionicons.notifications,
                                  color: AppColors.primaryText,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.amber,
                                    radius: 25,
                                    foregroundImage: NetworkImage('url'),
                                  ),
                                )
                              ],
                            ),
                          ),
                    //content /// isi screennya
                    Expanded(
                      child: Container(
                        padding: !context.isPhone
                            ? const EdgeInsets.all(50)
                            : const EdgeInsets.all(20),
                        margin: !context.isPhone
                            ? const EdgeInsets.all(10)
                            : const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: !context.isPhone
                                ? BorderRadius.circular(50)
                                : BorderRadius.circular(30)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'My Task',
                              style: TextStyle(
                                  color: AppColors.primaryText, fontSize: 30),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 8,
                                clipBehavior: Clip.antiAlias,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onLongPress: () {
                                      addEditTask(
                                          context: context,
                                          type: 'update',
                                          docId: '');
                                    },
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.cardBg,
                                      ),
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                child: const CircleAvatar(
                                                  backgroundColor: Colors.amber,
                                                  radius: 20,
                                                  foregroundImage:
                                                      NetworkImage('url'),
                                                ),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                child: const CircleAvatar(
                                                  backgroundColor: Colors.amber,
                                                  radius: 20,
                                                  foregroundImage:
                                                      NetworkImage('url'),
                                                ),
                                              ),
                                              const Spacer(),
                                              Container(
                                                height: 25,
                                                width: 80,
                                                color: AppColors.primaryBg,
                                                child: const Center(
                                                    child: Text(
                                                  '100 %',
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.primaryText,
                                                  ),
                                                )),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Container(
                                            height: 25,
                                            width: 80,
                                            color: AppColors.primaryBg,
                                            child: const Center(
                                                child: Text(
                                              '10/10 Task',
                                              style: TextStyle(
                                                color: AppColors.primaryText,
                                              ),
                                            )),
                                          ),
                                          const Text(
                                            'Pemrograman Website',
                                            style: TextStyle(
                                                color: AppColors.primaryText,
                                                fontSize: 20),
                                          ),
                                          const Text(
                                            'Deadline 1 hari lagi',
                                            style: TextStyle(
                                                color: AppColors.primaryText,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: const Alignment(0.95, 0.95),
        child: FloatingActionButton.extended(
          onPressed: () {
            addEditTask(context: context, type: 'Add', docId: '');
          },
          label: const Text('Add Task'),
          icon: const Icon(Ionicons.add),
        ),
      ),
    );
  }

  addEditTask({BuildContext? context, String? type, String? docId}) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      margin: context!.isPhone
          ? EdgeInsets.zero
          : const EdgeInsets.only(left: 5, right: 5),
      height: Get.height,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white),
      child: Form(
          key: controller.formKey,
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Text(
                '$type Task',
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                controller: controller.titlecontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Can not be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                controller: controller.descriptionsController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Can not be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DateTimePicker(
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                dateLabelText: 'Due Date',
                dateHintText: 'Due Date',
                decoration: InputDecoration(
                  hintText: 'Due Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                controller: controller.dueDateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'can not be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ConstrainedBox(
                  constraints:
                      BoxConstraints.tightFor(width: Get.width, height: 40),
                  child: ElevatedButton(
                      onPressed: () {
                        controller.saveUpdateTask(
                          title: controller.titlecontroller.text,
                          description: controller.descriptionsController.text,
                          dueDate: controller.dueDateController.text,
                          docId: docId,
                          type: type,
                        );
                      },
                      child: Text(type!))),
              const SizedBox(
                height: 10,
              ),
            ],
          )),
    ));
  }
}
