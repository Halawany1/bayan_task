import 'package:flutter/cupertino.dart';

class DataModel{
  int ?id;
  String ? name;
  String ? age;
  String  ?date;
  String  ?nationalyId;

  DataModel({this.id,this.name,this.age,this.date,this.nationalyId});

  DataModel.fromjson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    age=json['age'];
    date=json['date'];
    nationalyId=json['nationalyId'];
  }
}