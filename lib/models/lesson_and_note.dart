import 'package:student_notes/models/lesson_model.dart';

class LessonAndNotes {
  final  LessonModel lessons;
  List<num> interrogation ;
  List<num> devoir;

  LessonAndNotes({required this.lessons, List<num>? interrogation, List<num>? devoir}) : interrogation = interrogation ?? [], devoir = devoir?? [];
}