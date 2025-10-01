
import 'package:cloud_firestore/cloud_firestore.dart';

class LessonModel {
  final String? id;
  final String lessonname;
  final String imageUrl;

  LessonModel({this.id, required this.lessonname, required this.imageUrl});
  
  Map<String, dynamic> toJson() {
    return {
      'lessonname': lessonname,  
      'imageUrl': imageUrl,      
    };
  }

   //  fromSnapshot reste correct
  static LessonModel fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return LessonModel(
      id: snapshot.id,
      lessonname: snap['lessonname'] ?? 'N/A',  
      imageUrl: snap['imageUrl'] ?? 'N/A',      
    );
  }

  static LessonModel fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      lessonname: json['lessonname'] ?? 'N/A',
      imageUrl: json['imageUrl'] ?? 'N/A',
    );
  }
}





List<LessonModel> lessons = [
  LessonModel(lessonname: "Mathématiques", imageUrl: "assets/images/math.jpeg"),
  LessonModel(lessonname: "PCT", imageUrl: "assets/images/pct.jpeg"),
  LessonModel(lessonname: "Français", imageUrl: "assets/images/francais.jpeg"),
  LessonModel(lessonname: "SVT",imageUrl: "assets/images/svt.jpeg"),
  LessonModel(lessonname: "Anglais",imageUrl: "assets/images/anglais.jpeg"),
  LessonModel(lessonname: "Histoire-Géo",imageUrl: "assets/images/hg.png"),
]; 