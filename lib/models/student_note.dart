import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_notes/models/lesson_and_note.dart';
import 'package:student_notes/models/student_model.dart';
import 'package:student_notes/models/lesson_model.dart';

class StudentNote {
  final String? id;
  final StudentModel students;
  final List<LessonAndNotes> lessonsAndNotes;

  StudentNote({this.id, required this.students, required this.lessonsAndNotes});

  Map<String, dynamic> toJson() {
    return {
      'students': students.toJson(),
      'lessonsAndNotes': lessonsAndNotes.map((ln) => ln.toJson()).toList(),
    };
  }

   static StudentNote fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;

    return StudentNote(
      id: snapshot.id,
      students: StudentModel.fromJson(data['students'] as Map<String, dynamic>),
      lessonsAndNotes: (data['lessonsAndNotes'] as List)
          .map((item) => LessonAndNotes.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  


}

List<StudentNote> studentNotes = [
  StudentNote(
    students: students[0],
    lessonsAndNotes: [
      LessonAndNotes(lessons: lessons[0], interrogation: [10.5, 13.5, 12], devoir: [12.75, 13.5]),
      LessonAndNotes(lessons: lessons[1], interrogation: [11, 14, 13.25], devoir: [13, 14.25]),
      LessonAndNotes(lessons: lessons[2], interrogation: [12.5, 15, 13.75], devoir: [12.25, 15.5]),
      LessonAndNotes(lessons: lessons[3], interrogation: [13, 12.75, 14.5], devoir: [13.5, 14]),
      LessonAndNotes(lessons: lessons[4], interrogation: [14, 15.5, 13.25], devoir: [12.75, 14.25]),
      LessonAndNotes(lessons: lessons[5], interrogation: [13.5, 14.75, 12.5], devoir: [13, 15]),
    ],
  ),
  StudentNote(
    students: students[1],
    lessonsAndNotes: [
      LessonAndNotes(lessons: lessons[0], interrogation: [15, 16.5, 14.75], devoir: [14, 16]),
      LessonAndNotes(lessons: lessons[1], interrogation: [16, 15.25, 14], devoir: [15, 16.5]),
      LessonAndNotes(lessons: lessons[2], interrogation: [14.5, 17, 15.5], devoir: [15.25, 16]),
      LessonAndNotes(lessons: lessons[3], interrogation: [16.75, 15, 16.5], devoir: [15.5, 17]),
      LessonAndNotes(lessons: lessons[4], interrogation: [15.25, 17.5, 16], devoir: [16, 17.25]),
      LessonAndNotes(lessons: lessons[5], interrogation: [16, 17, 15.75], devoir: [15.75, 17]),
    ],
  ),
  StudentNote(
    students: students[2],
    lessonsAndNotes: [
      LessonAndNotes(lessons: lessons[0], interrogation: [9.5, 13, 10.75], devoir: [11.5, 13.25]),
      LessonAndNotes(lessons: lessons[1], interrogation: [12, 11.25, 14.5], devoir: [10.75, 12.5]),
      LessonAndNotes(lessons: lessons[2], interrogation: [13.5, 12, 15], devoir: [13, 14.25]),
      LessonAndNotes(lessons: lessons[3], interrogation: [10.25, 13.75, 12.5], devoir: [12, 13.5]),
      LessonAndNotes(lessons: lessons[4], interrogation: [14, 12.5, 13.25], devoir: [11.75, 13]),
      LessonAndNotes(lessons: lessons[5], interrogation: [11, 14.5, 12.75], devoir: [12.25, 13.75]),
    ],
  ),
  StudentNote(
    students: students[3],
    lessonsAndNotes: [
      LessonAndNotes(lessons: lessons[0], interrogation: [16, 15.5, 14.25], devoir: [15, 16.5]),
      LessonAndNotes(lessons: lessons[1], interrogation: [17.25, 16, 15.75], devoir: [14.5, 15.75]),
      LessonAndNotes(lessons: lessons[2], interrogation: [18, 17.5, 16.25], devoir: [15.25, 16]),
      LessonAndNotes(lessons: lessons[3], interrogation: [15.5, 16.75, 17], devoir: [16, 17.25]),
      LessonAndNotes(lessons: lessons[4], interrogation: [17, 18.25, 16.5], devoir: [15.75, 16.5]),
      LessonAndNotes(lessons: lessons[5], interrogation: [16.25, 17, 15.5], devoir: [16.25, 17]),
    ],
  ),
  // Fatou Diallo
  StudentNote(
    students: students[4],
    lessonsAndNotes: [
      LessonAndNotes(lessons: lessons[0], interrogation: [12, 13, 14], devoir: [13, 14]),
      LessonAndNotes(lessons: lessons[1], interrogation: [13, 12, 15], devoir: [14, 13.5]),
      LessonAndNotes(lessons: lessons[2], interrogation: [14, 13.5, 12.5], devoir: [13.5, 14]),
      LessonAndNotes(lessons: lessons[3], interrogation: [13.5, 14, 13], devoir: [14, 13.5]),
      LessonAndNotes(lessons: lessons[4], interrogation: [14, 13, 13.5], devoir: [13, 14]),
      LessonAndNotes(lessons: lessons[5], interrogation: [13, 14, 13.5], devoir: [14, 13]),
    ],
  ),
  // Serge Adjovi
  StudentNote(
    students: students[5],
    lessonsAndNotes: [
      LessonAndNotes(lessons: lessons[0], interrogation: [11, 12, 13], devoir: [12, 13]),
      LessonAndNotes(lessons: lessons[1], interrogation: [12, 11, 14], devoir: [13, 12.5]),
      LessonAndNotes(lessons: lessons[2], interrogation: [13, 12.5, 11.5], devoir: [12.5, 13]),
      LessonAndNotes(lessons: lessons[3], interrogation: [12.5, 13, 12], devoir: [13, 12.5]),
      LessonAndNotes(lessons: lessons[4], interrogation: [13, 12, 12.5], devoir: [12, 13]),
      LessonAndNotes(lessons: lessons[5], interrogation: [12, 13, 12.5], devoir: [13, 12]),
    ],
  ),
  // Mariam Bello
  StudentNote(
    students: students[6],
    lessonsAndNotes: [
      LessonAndNotes(lessons: lessons[0], interrogation: [14, 15, 13.5], devoir: [15, 14.5]),
      LessonAndNotes(lessons: lessons[1], interrogation: [15, 14, 16], devoir: [14.5, 15]),
      LessonAndNotes(lessons: lessons[2], interrogation: [16, 15.5, 14.5], devoir: [15.5, 16]),
      LessonAndNotes(lessons: lessons[3], interrogation: [15.5, 16, 15], devoir: [16, 15.5]),
      LessonAndNotes(lessons: lessons[4], interrogation: [16, 15, 15.5], devoir: [15, 16]),
      LessonAndNotes(lessons: lessons[5], interrogation: [15, 16, 15.5], devoir: [16, 15]),
    ],
  ),
  // Julien Kouassi
  StudentNote(
    students: students[7],
    lessonsAndNotes: [
      LessonAndNotes(lessons: lessons[0], interrogation: [13, 14, 12.5], devoir: [14, 13.5]),
      LessonAndNotes(lessons: lessons[1], interrogation: [14, 13, 15], devoir: [13.5, 14]),
      LessonAndNotes(lessons: lessons[2], interrogation: [15, 14.5, 13.5], devoir: [14.5, 15]),
      LessonAndNotes(lessons: lessons[3], interrogation: [14.5, 15, 14], devoir: [15, 14.5]),
      LessonAndNotes(lessons: lessons[4], interrogation: [15, 14, 14.5], devoir: [14, 15]),
      LessonAndNotes(lessons: lessons[5], interrogation: [14, 15, 14.5], devoir: [15, 14]),
    ],
  ),
  // Esther Gbèdo
  StudentNote(
    students: students[8],
    lessonsAndNotes: [
      LessonAndNotes(lessons: lessons[0], interrogation: [12.5, 13.5, 14], devoir: [13.5, 14]),
      LessonAndNotes(lessons: lessons[1], interrogation: [13.5, 12.5, 15], devoir: [14, 13.5]),
      LessonAndNotes(lessons: lessons[2], interrogation: [14.5, 13.5, 12.5], devoir: [13.5, 14]),
      LessonAndNotes(lessons: lessons[3], interrogation: [13.5, 14, 13], devoir: [14, 13.5]),
      LessonAndNotes(lessons: lessons[4], interrogation: [14, 13, 13.5], devoir: [13, 14]),
      LessonAndNotes(lessons: lessons[5], interrogation: [13, 14, 13.5], devoir: [14, 13]),
    ],
  ),
  // David Tossou
  StudentNote(
    students: students[9],
    lessonsAndNotes: [
      LessonAndNotes(lessons: lessons[0], interrogation: [11.5, 12.5, 13], devoir: [12.5, 13]),
      LessonAndNotes(lessons: lessons[1], interrogation: [12.5, 11.5, 14], devoir: [13, 12.5]),
      LessonAndNotes(lessons: lessons[2], interrogation: [13.5, 12.5, 11.5], devoir: [12.5, 13]),
      LessonAndNotes(lessons: lessons[3], interrogation: [12.5, 13, 12], devoir: [13, 12.5]),
      LessonAndNotes(lessons: lessons[4], interrogation: [13, 12, 12.5], devoir: [12, 13]),
      LessonAndNotes(lessons: lessons[5], interrogation: [12, 13, 12.5], devoir: [13, 12]),
    ],
  ),
  // Chantal Ahouansou
  StudentNote(
    students: students[10],
    lessonsAndNotes: [
      LessonAndNotes(lessons: lessons[0], interrogation: [14, 15, 13.5], devoir: [15, 14.5]),
      LessonAndNotes(lessons: lessons[1], interrogation: [15, 14, 16], devoir: [14.5, 15]),
      LessonAndNotes(lessons: lessons[2], interrogation: [16, 15.5, 14.5], devoir: [15.5, 16]),
      LessonAndNotes(lessons: lessons[3], interrogation: [15.5, 16, 15], devoir: [16, 15.5]),
      LessonAndNotes(lessons: lessons[4], interrogation: [16, 15, 15.5], devoir: [15, 16]),
      LessonAndNotes(lessons: lessons[5], interrogation: [15, 16, 15.5], devoir: [16, 15]),
    ],
  ),
  // Eric Soglo
  StudentNote(
    students: students[11],
    lessonsAndNotes: [
      LessonAndNotes(lessons: lessons[0], interrogation: [13, 14, 12.5], devoir: [14, 13.5]),
      LessonAndNotes(lessons: lessons[1], interrogation: [14, 13, 15], devoir: [13.5, 14]),
      LessonAndNotes(lessons: lessons[2], interrogation: [15, 14.5, 13.5], devoir: [14.5, 15]),
      LessonAndNotes(lessons: lessons[3], interrogation: [14.5, 15, 14], devoir: [15, 14.5]),
      LessonAndNotes(lessons: lessons[4], interrogation: [15, 14, 14.5], devoir: [14, 15]),
      LessonAndNotes(lessons: lessons[5], interrogation: [14, 15, 14.5], devoir: [15, 14]),
    ],
  ),
  // Nadine Kpèdétin
  StudentNote(
    students: students[12],
    lessonsAndNotes: [
      LessonAndNotes(lessons: lessons[0], interrogation: [12.5, 13.5, 14], devoir: [13.5, 14]),
      LessonAndNotes(lessons: lessons[1], interrogation: [13.5, 12.5, 15], devoir: [14, 13.5]),
      LessonAndNotes(lessons: lessons[2], interrogation: [14.5, 13.5, 12.5], devoir: [13.5, 14]),
      LessonAndNotes(lessons: lessons[3], interrogation: [13.5, 14, 13], devoir: [14, 13.5]),
      LessonAndNotes(lessons: lessons[4], interrogation: [14, 13, 13.5], devoir: [13, 14]),
      LessonAndNotes(lessons: lessons[5], interrogation: [13, 14, 13.5], devoir: [14, 13]),
    ],
  ),
  // Paul Agbessi
  StudentNote(
    students: students[13],
    lessonsAndNotes: [
      LessonAndNotes(lessons: lessons[0], interrogation: [11, 12, 13], devoir: [12, 13]),
      LessonAndNotes(lessons: lessons[1], interrogation: [12, 11, 14], devoir: [13, 12.5]),
      LessonAndNotes(lessons: lessons[2], interrogation: [13, 12.5, 11.5], devoir: [12.5, 13]),
      LessonAndNotes(lessons: lessons[3], interrogation: [12.5, 13, 12], devoir: [13, 12.5]),
      LessonAndNotes(lessons: lessons[4], interrogation: [13, 12, 12.5], devoir: [12, 13]),
      LessonAndNotes(lessons: lessons[5], interrogation: [12, 13, 12.5], devoir: [13, 12]),
    ],
  ),
];
