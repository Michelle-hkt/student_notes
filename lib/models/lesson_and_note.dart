import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_notes/models/lesson_model.dart';

class LessonAndNotes {
  final String? id;
  final  LessonModel lessons;
  List<num> interrogation ;
  List<num> devoir;

  LessonAndNotes({this.id, required this.lessons, List<num>? interrogation, List<num>? devoir}) : interrogation = interrogation ?? [], devoir = devoir?? [];

  
  Map<String, dynamic> toJson() {
    return {
      'lessons': lessons.toJson(), 
      'interrogation': interrogation,
      'devoir': devoir,
    };
  }

 
  static LessonAndNotes fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return LessonAndNotes(
      id: snapshot.id,
      lessons: LessonModel.fromJson(snap['lessons'] as Map<String, dynamic>),
      interrogation: List<num>.from(snap['interrogation'] ?? []),
      devoir: List<num>.from(snap['devoir'] ?? []), 
    );
  }

  // ✅ AJOUT OBLIGATOIRE : méthode fromJson
  static LessonAndNotes fromJson(Map<String, dynamic> json) {
    return LessonAndNotes(
      id: json['id'],
      lessons: LessonModel.fromJson(json['lessons'] as Map<String, dynamic>),
      interrogation: List<num>.from(json['interrogation'] ?? []),
      devoir: List<num>.from(json['devoir'] ?? []),
    );
  }

}