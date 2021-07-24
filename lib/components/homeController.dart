import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebasecrude/components/customDialog.dart';
import 'package:flutterfirebasecrude/components/customSnackBar.dart';
import 'package:flutterfirebasecrude/components/employeeModel.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController, addressController;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  RxList<EmployeeModel> employees = RxList<EmployeeModel>([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nameController = TextEditingController();
    addressController = TextEditingController();
    collectionReference = firebaseFirestore.collection("employees");

    employees.bindStream(getAllEmployees());
  }

  Stream<List<EmployeeModel>> getAllEmployees() =>
      collectionReference.snapshots().map((event) =>
          event.docs.map((e) => EmployeeModel.fromMap(e)).toList());

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Name can not be empty";
    } else {
      return null;
    }
  }

  String? validateAddress(String value) {
    if (value.isEmpty) {
      return "Address can not be empty";
    } else {
      return null;
    }
  }

  void saveUpdateEmployee(String name, String address, String docID, int addEditFlag) {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    if (addEditFlag == 1) {
      CustomFullScreenDialog.showDialog();

      collectionReference.add({'name': name, 'address': address}).whenComplete(() {
        CustomFullScreenDialog.cancelDialog();
        clearEditing();
        Get.back();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: "Employee Added",
            message: "Employee Added "
                "Successfilly",
            backColor: Colors.white);
      }).catchError((error) {
        CustomFullScreenDialog.cancelDialog();
        CustomSnackBar.showSnackBar(
            context: Get.context, title: "Error", message: "Something went wrong", backColor: Colors.white);
      });
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    nameController.dispose();
    addressController.dispose();
  }

  void clearEditing() {
    nameController.clear();
    addressController.clear();
  }
}
