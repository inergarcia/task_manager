import 'dart:convert';

import 'package:task_manager/src/models/user.dart';

class Task {
  int? id;
  String title;
  String description;
  String type;
  String complianceDate;
  User responsable;
  User author;
  String project;
  String state;
  List<User> users;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.complianceDate,
    required this.responsable,
    required this.author,
    required this.project,
    required this.state,
    required this.users,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    List<dynamic> usersList = jsonDecode(json['users']);
    Map<String, dynamic> author = jsonDecode(json['author']);
    Map<String, dynamic> responsable = jsonDecode(json['responsable']);

    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      complianceDate: json['complianceDate'],
      responsable: User.fromJson(responsable),
      author: User.fromJson(author),
      project: json['project'],
      state: json['state'],
      users: List.generate(
        usersList.length,
        (index) => User.fromJson(usersList[index]),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
      'complianceDate': complianceDate,
      'responsable': jsonEncode(responsable.toJson()),
      'author': jsonEncode(author.toJson()),
      'project': project,
      'state': state,
      'users': jsonEncode(
        List.generate(
          users.length,
          (index) => users[index].toJson(),
        ),
      ),
    };
  }
}
