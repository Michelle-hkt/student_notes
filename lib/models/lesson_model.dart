class LessonModel {
  final String lessonname;
  List<int> notes ;

  LessonModel({required this.lessonname, List<int>? notes,}): notes = notes ?? [];
}

List<LessonModel> lessons = [
  LessonModel(lessonname: "Mathématiques"),
  LessonModel(lessonname: "PCT"),
  LessonModel(lessonname: "Français"),
  LessonModel(lessonname: "SVT"),
  LessonModel(lessonname: "Anglais"),
  LessonModel(lessonname: "Histoire-Géo"),
];