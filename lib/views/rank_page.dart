import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_notes/controllers/student_note_controller.dart';
import 'package:student_notes/models/student_note.dart';
import 'package:student_notes/utils/average_extension.dart'; // ton extension classement

class RankPage extends StatefulWidget {
  const RankPage({super.key});

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  final StudentNoteController studentNoteController = StudentNoteController();

  String convertInInt(num note) {
    if (note % 1 == 0) {
      return note.toInt().toString(); // retire le .0 si entier
    } else {
      return note.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDBEEFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Classement des étudiants"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Nom et Rang
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Nom et prénom",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "Rang",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const Divider(color: Colors.black26),

            // Liste des étudiants avec FutureBuilder
            Expanded(
              child: FutureBuilder<List<StudentNote>>(
                future: studentNoteController.getAllStudentNotes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Erreur lors de la récupération des étudiants",
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Aucun étudiant disponible"));
                  } else {
                    // Trier les étudiants par moyenne
                    final sortedStudents = snapshot.data!.classement();

                    return ListView.builder(
                      itemCount: sortedStudents.length,
                      itemBuilder: (context, index) {
                        final studentNote = sortedStudents[index];
                        final student = studentNote.students;

                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${student.firstname} ${student.lastname}",
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    "${index + 1}", // rang
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(color: Colors.black26),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
