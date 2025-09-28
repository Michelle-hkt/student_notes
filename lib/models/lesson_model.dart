
class LessonModel {
  final String lessonname;
  final String imageUrl;

  LessonModel({required this.lessonname, required this.imageUrl});

}

List<LessonModel> lessons = [
  LessonModel(lessonname: "Mathématiques", imageUrl: "assets/images/math.jpeg"),
  LessonModel(lessonname: "PCT", imageUrl: "assets/images/pct.jpeg"),
  LessonModel(lessonname: "Français", imageUrl: "assets/images/francais.jpeg"),
  LessonModel(lessonname: "SVT",imageUrl: "assets/images/svt.jpeg"),
  LessonModel(lessonname: "Anglais",imageUrl: "assets/images/anglais.jpeg"),
  LessonModel(lessonname: "Histoire-Géo",imageUrl: "assets/images/hg.png"),
];