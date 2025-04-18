import 'dart:convert';
import 'package:todo_list_app/models/todomodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

const key ='todo_list';

class SharedPrefApi {
   Future<List<Todomodel>> getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key) ?? '[]';
    final jsonDecoded = json.decode(jsonString) as List;

    return jsonDecoded
        .map(
          (e) => Todomodel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  //save list
  void saveList(List<Todomodel> todos) async {
    final stringJson = json.encode(todos);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, stringJson);
  }

  //update List
  void updateList(List<Todomodel> todos, int id, String task, String date,
      String description) async {
    for (var i in todos) {
      if (i.id == id) {
        i.task = task;
        i.description = description;
        i.date = date;
      }
    }
    saveList(todos);    
  }
}