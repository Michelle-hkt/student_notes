import 'package:student_notes/models/lesson_model.dart';
import 'package:student_notes/models/student_model.dart';

class ReportCardModel {
  final List<LessonModel> lessons;
  final List<StudentModel> students;
  int moyenne;

  ReportCardModel({required this.lessons, required this.students, int? moyenne}): moyenne = moyenne ?? 00;
}