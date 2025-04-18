import 'dart:convert';

List<Todomodel> postModelFromJson(String str)=>
    List<Todomodel>.from(json.decode(str).map((x) => Todomodel.fromJson(x)));

String postModelToJson(List<Todomodel> data) =>
    json.encode(List<dynamic>.from(data.map((e) => e.toJson())));

class Todomodel {

  Todomodel({
    required this.id,
    required this.task,
    required this.description,
    required this.date,
  });
  int id;
  String task;
  String description;
  String date;

  factory Todomodel.fromJson(Map<String, dynamic> json) => Todomodel(
    id : json['id'], 
    task: json['task'], 
    description : json['description'], 
    date : json['date']);

  Map<String, dynamic> toJson() => {
    "id" : id,
    "task" : task,
    "description" : description,
    "date" : date,
  };
}



