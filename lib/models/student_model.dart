class StudentModel {
  final String firstname;
  final String lastname;
  final int age;
  String className;

  StudentModel({required this.firstname, required this.lastname, required this.age, required this.className});
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