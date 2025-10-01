import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:student_notes/models/lesson_model.dart';

class LessonController {
  var lessonDB = FirebaseFirestore.instance.collection('lessons');

  Future<void> createLesson(LessonModel lesson) async {
    try {
      await lessonDB.add(lesson.toJson());
    } on Exception catch (e) {
      ;
      Get.snackbar(
        'Une erreur est survenue',
        "Veuillez ressayer ultérieurement. Contactez le support si le problème persiste.\n",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<List<LessonModel>> getAllLessons() async {
    try {
      final snapshot = await lessonDB.get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((d) => LessonModel.fromSnapshot(d)).toList();
      } else {
        return [];
      }
    } on Exception catch (e) {
      ;
      Get.snackbar(
        'Une erreur est survenue',
        "Veuillez ressayer ultérieurement. Contactez le support si le problème persiste.\n",
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }
  }
}
