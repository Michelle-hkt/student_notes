
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:student_notes/models/my_user.dart';

class UserController {

  var userDb = FirebaseFirestore.instance.collection('users');

  Future<void> createUser(MyUser user) async {
    try {
      await userDb.add(user.toJson());
    } on Exception catch (e) {
      Get.snackbar(
        'Une erreur est survenue',
        "Veuillez ressayer ultérieurement. Contactez le support si le problème persiste.\n",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  
}