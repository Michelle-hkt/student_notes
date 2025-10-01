import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:student_notes/models/student_note.dart';

class StudentNoteController {
  var studentNoteDB = FirebaseFirestore.instance.collection('studentsNotes');

  Future<void> createStudentNote(StudentNote studentNote) async {
    try {
      // Vérifier si l'étudiant existe déjà (par firstname + lastname)
      final querySnapshot = await studentNoteDB
          .where(
            'students.firstname',
            isEqualTo: studentNote.students.firstname,
          )
          .where('students.lastname', isEqualTo: studentNote.students.lastname)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // L'étudiant existe : mettre à jour ses lessonsAndNotes
        final existingDocId = querySnapshot.docs.first.id;
        final existingData = StudentNote.fromSnapshot(querySnapshot.docs.first);

        // Fusionner les anciennes et nouvelles lessonsAndNotes
        final updatedLessonsAndNotes = [
          ...existingData.lessonsAndNotes,
          ...studentNote.lessonsAndNotes,
        ];

        // Mettre à jour le document existant
        await studentNoteDB.doc(existingDocId).update({
          'lessonsAndNotes': updatedLessonsAndNotes
              .map((ln) => ln.toJson())
              .toList(),
        });

        Get.snackbar(
          'Succès',
          "Notes ajoutées pour ${studentNote.students.firstname} ${studentNote.students.lastname}",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        // L'étudiant n'existe pas : créer un nouveau document
        await studentNoteDB.add(studentNote.toJson());

        Get.snackbar(
          'Succès',
          "Nouvel étudiant créé avec succès",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on Exception catch (e) {
      Get.snackbar(
        'Une erreur est survenue',
        "Veuillez réessayer ultérieurement. Contactez le support si le problème persiste.\n",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<List<StudentNote>> getAllStudentNotes() async {
    try {
      final snapshot = await studentNoteDB.get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((d) => StudentNote.fromSnapshot(d)).toList();
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
