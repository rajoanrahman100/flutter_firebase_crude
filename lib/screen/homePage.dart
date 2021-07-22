import 'package:flutter/material.dart';
import 'package:flutterfirebasecrude/components/homeController.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Crude"),
        actions: [
          IconButton(
              onPressed: () {
                _buildAddEditEmployeeView(text: "ADD",addEditFlag: 1,docId: "");
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Container(),
    );
  }

  _buildAddEditEmployeeView({String? text, int? addEditFlag, String? docId}) {
    Get.bottomSheet(Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16.0),
            topLeft: Radius.circular(16.0),
          ),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "$text employee",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Name", border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                  controller: controller.nameController,
                  validator: (value) {
                    return controller.validateName(value!);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Address", border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                  controller: controller.addressController,
                  validator: (value) {
                    return controller.validateAddress(value!);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      controller.saveUpdateEmployee(
                          controller.nameController.text, controller.addressController.text, docId!, addEditFlag!);
                    },
                    child: Text("$text"))
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
