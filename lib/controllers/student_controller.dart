import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/route_manager.dart';
import 'package:student_notes/models/student_model.dart';


class StudentController {
  var studentDb = FirebaseFirestore.instance.collection('students');

  Future<void> createStudent(StudentModel student) async {
    
    try {
      await studentDb.add(student.toJson());
    } on Exception catch (e) {;
      Get.snackbar(
        'Une erreur est survenue',
        "Veuillez ressayer ultérieurement. Contactez le support si le problème persiste.\n",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<List<StudentModel>> getAllStudents() async {
    try {
      final snapshot = await studentDb.get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((d) => StudentModel.fromSnapshot(d)).toList();
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