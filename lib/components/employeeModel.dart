import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeModel{
  String? docID;
  String? name;
  String? address;

  EmployeeModel({this.docID,this.name,this.address});

  EmployeeModel.fromMap(DocumentSnapshot data){
    docID=data.id;
    name=data["name"];
    address=data["address"];
  }

}