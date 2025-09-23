import 'package:student_notes/models/lesson_and_note.dart';
import 'package:student_notes/models/student_model.dart';
import 'package:student_notes/models/lesson_model.dart';

class StudentNote {
  final StudentModel students;
  final List<LessonAndNotes> lessonsAndNotes;

  StudentNote({required this.students, required this.lessonsAndNotes});
}

List<StudentNote> studentNotes = [
  StudentNote(
    students: students[0],
    lessonsAndNotes: [
      LessonAndNotes(lessons: lessons[0], notes: [12.3, 18, 12, 14, 19]),
      LessonAndNotes(lessons: lessons[1], notes: [14, 16, 13, 15.5, 17]),
      LessonAndNotes(lessons: lessons[2], notes: [13, 15, 14, 12, 16]),
      LessonAndNotes(lessons: lessons[3], notes: [16, 14.75, 15, 17, 18]),
      LessonAndNotes(lessons: lessons[4], notes: [15, 17, 16, 14, 18]),
      LessonAndNotes(lessons: lessons[5], notes: [14, 16, 15, 13, 17]),
    ],
  ),
  StudentNote(
    students: students[1],
    lessonsAndNotes: [
      LessonAndNotes(lessons: lessons[0], notes: [12.5, 14, 11.75, 13, 15]),
      LessonAndNotes(lessons: lessons[1], notes: [13, 15.25, 12, 14.5, 16]),
      LessonAndNotes(lessons: lessons[2], notes: [14, 16.5, 15, 13.25, 17]),
      LessonAndNotes(lessons: lessons[3], notes: [15.75, 13, 14.5, 16, 17.5]),
      LessonAndNotes(lessons: lessons[4], notes: [14, 16.25, 15, 13.5, 18]),
      LessonAndNotes(lessons: lessons[5], notes: [13.5, 15, 14.25, 12, 16]),
    ],
  ),
  StudentNote(
    students: students[2],
    lessonsAndNotes: [
      LessonAndNotes(lessons: lessons[0], notes: [10, 12.5, 11, 13.75, 14]),
      LessonAndNotes(lessons: lessons[1], notes: [11.5, 13, 12.25, 14, 15.5]),
      LessonAndNotes(lessons: lessons[2], notes: [12, 14.5, 13, 11.25, 16]),
      LessonAndNotes(lessons: lessons[3], notes: [0, 11.5, 12, 14.25, 15]),
      LessonAndNotes(lessons: lessons[4], notes: [12.75, 14, 13.5, 11, 16.25]),
      LessonAndNotes(lessons: lessons[5], notes: [11, 13.5, 12.25, 10, 15.75]),
    ],
  ),
  StudentNote(
    students: students[3],
    lessonsAndNotes: [
      LessonAndNotes(lessons: lessons[0], notes: [14, 16.5, 0, 13.25, 17]),
      LessonAndNotes(lessons: lessons[1], notes: [15.75, 17, 16.25, 14, 18.5]),
      LessonAndNotes(lessons: lessons[2], notes: [16, 18.25, 17, 15.5, 19]),
      LessonAndNotes(lessons: lessons[3], notes: [17.5, 15, 16.75, 18, 19.25]),
      LessonAndNotes(lessons: lessons[4], notes: [16.5, 18, 17.25, 15, 20]),
      LessonAndNotes(lessons: lessons[5], notes: [15, 17.5, 16.25, 14, 18.75]),
    ],
  ),
];
