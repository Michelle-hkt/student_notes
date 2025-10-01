import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  final String? id;
  final String firstname;
  final String lastname;
  final int age;
  String className;

  StudentModel({this.id, required this.firstname, required this.lastname, required this.age, required this.className});

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'age': age,
      'className': className
    };
  }

   static StudentModel fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return StudentModel(
        id: snapshot.id,
        firstname: snap['firstname'],
        lastname: snap['lastname'],
        age: snap['age'],
        className: snap['className']);
  }

  static StudentModel fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'],
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      age: json['age'] ?? 0,
      className: json['className'] ?? ''
    );
  }

  
}

List<StudentModel> students = [
  StudentModel(firstname: "Yannick", lastname: "Agossa", age: 20, className: "1ère D"),
  StudentModel(firstname: "Clarisse", lastname: "Houngbédji", age: 17, className: "1ère D"),
  StudentModel(firstname: "Aminatou", lastname: "Sanni", age: 19, className: "1ère D"),
  StudentModel(firstname: "Roméo", lastname: "Koukpè", age: 18, className: "1ère D"),
  StudentModel(firstname: "Fatou", lastname: "Diallo", age: 18, className: "1ère D"),
  StudentModel(firstname: "Serge", lastname: "Adjovi", age: 17, className: "1ère D"),
  StudentModel(firstname: "Mariam", lastname: "Bello", age: 19, className: "1ère D"),
  StudentModel(firstname: "Julien", lastname: "Kouassi", age: 20, className: "1ère D"),
  StudentModel(firstname: "Esther", lastname: "Gbèdo", age: 18, className: "1ère D"),
  StudentModel(firstname: "David", lastname: "Tossou", age: 17, className: "1ère D"),
  StudentModel(firstname: "Chantal", lastname: "Ahouansou", age: 19, className: "1ère D"),
  StudentModel(firstname: "Eric", lastname: "Soglo", age: 18, className: "1ère D"),
  StudentModel(firstname: "Nadine", lastname: "Kpèdétin", age: 20, className: "1ère D"),
  StudentModel(firstname: "Paul", lastname: "Agbessi", age: 17, className: "1ère D"),
];