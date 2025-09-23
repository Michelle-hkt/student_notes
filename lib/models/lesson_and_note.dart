import 'package:student_notes/models/lesson_model.dart';

class LessonAndNotes {
  final  LessonModel lessons;
  List<num> notes;

  LessonAndNotes({required this.lessons, List<num>? notes}) : notes = notes ?? [];
}