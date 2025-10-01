import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_notes/controllers/student_controller.dart';
import 'package:student_notes/models/student_model.dart';
import 'package:student_notes/views/report_card.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String writtenText = ""; // texte tapé dans la searchbar
  final StudentController studentController = StudentController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDBEEFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Veuillez entrer le nom de l'étudiant",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              child: SearchBar(
                leading: const Icon(Icons.search, color: Color(0xFF8C8C8C)),
                hintText: "Rechercher ...",
                backgroundColor: WidgetStatePropertyAll(Color(0xFFFFFFFF)),
                elevation: WidgetStatePropertyAll(0),
                onChanged: (value) {
                  setState(() {
                    writtenText = value;
                  });
                },
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Liste des étudiants récupérés depuis Firestore
            Expanded(
              child: FutureBuilder<List<StudentModel>>(
                future: studentController.getAllStudents(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        "Erreur lors de la récupération des étudiants",
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Aucun étudiant disponible"));
                  } else {
                    // Filtrer les étudiants selon le texte tapé
                    final students = snapshot.data!;
                    final suggestions = writtenText.isEmpty
                        ? []
                        : students.where((student) {
                            final fullName = "${student.firstname} ${student.lastname}".toLowerCase();
                            return fullName.contains(writtenText.toLowerCase());
                          }).toList();

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        final student = suggestions[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: ListTile(
                            title: Text("${student.firstname} ${student.lastname}"),
                            onTap: () {
                              Get.to(() => ReportCard(student: student));
                            },
                          ),
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
