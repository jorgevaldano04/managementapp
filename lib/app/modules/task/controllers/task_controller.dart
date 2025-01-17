import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/app/data/controller/auth_controller.dart';

class TaskController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final authCon = Get.find<AuthController>();

  late TextEditingController titlecontroller,
      descriptionsController,
      dueDateController;

  @override
  void onInit() {
    super.onInit();
    titlecontroller = TextEditingController();
    descriptionsController = TextEditingController();
    dueDateController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    titlecontroller.dispose();
    descriptionsController.dispose();
    dueDateController.dispose();
  }

  void saveUpdateTask({
    String? title,
    String? description,
    String? dueDate,
    String? docId,
    String? type,
  }) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    CollectionReference taskColl = firestore.collection('task');
    CollectionReference usersColl = firestore.collection('task');
    var taskId = DateTime.now().toIso8601String();
    if (type == 'Add') {
      await taskColl.doc(taskId).set({
        'title': title,
        'description': description,
        'dueDate': dueDate,
        'status': '0',
        'total_task': '0',
        'total_task_finsihed': '0',
        'task_detail': [],
        'assign_to': [authCon.auth.currentUser!.email],
        'created_by': authCon.auth.currentUser!.email,
      }).whenComplete(() async {
        await usersColl.doc(authCon.auth.currentUser!.email).set({
          'task_id': FieldValue.arrayUnion([taskId])
        }, SetOptions(merge: true));
        Get.back();
        Get.snackbar('Task', 'Succesfully $type');
      }).catchError((error) {
        Get.snackbar('Task', 'Error $type');
      });
    } else {
      await taskColl.doc(docId).update({
        'title': title,
        'description': description,
        'dueDate': dueDate,
      }).whenComplete(() async {
        await usersColl.doc(authCon.auth.currentUser!.email).set({
          'task_id': FieldValue.arrayUnion([taskId])
        }, SetOptions(merge: true));
        Get.back();
        Get.snackbar('Task', 'Succesfully $type');
      }).catchError((error) {
        Get.snackbar('Task', 'Error $type');
      });
    }
  }
}
