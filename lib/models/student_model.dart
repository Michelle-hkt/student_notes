class StudentModel {
  final String firstname;
  final String lastname;
  final int age;
  String className;

  StudentModel({required this.firstname, required this.lastname, required this.age, required this.className});
}

List<StudentModel> students = [
  StudentModel(firstname: "John", lastname: "Doe", age: 20, className: "1ère D"),
  StudentModel(firstname: "Jane", lastname: "Smith", age: 22, className: "1ère D"),
  StudentModel(firstname: "Alice", lastname: "Johnson", age: 19, className: "1ère D"),
  StudentModel(firstname: "Bob", lastname: "Brown", age: 21, className: "1ère D"),
];