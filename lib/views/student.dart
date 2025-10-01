import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_notes/controllers/student_controller.dart';
import 'package:student_notes/models/student_model.dart';
import 'package:student_notes/views/note_page.dart';

class Student extends StatefulWidget {
  const Student({super.key});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  /* @override
  void initState() {
    super.initState();
    _addStudentsOnStart();
  }

  // Fonction pour exécuter l'ajout au démarrage
  void _addStudentsOnStart() async {
    await addAllStudents();
    log("Tous les étudiants ont été ajoutés !");
  } */

  String firstname = "";
  String lastname = "";
  int age = 0;
  String className = "";

  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _ageController = TextEditingController();
  final _classController = TextEditingController();

  final _keyForm = GlobalKey<FormState>();

  String writtenText = "";

  StudentController studentController = StudentController();

  void saveStudentToFirebase() async {
    StudentModel userToSave = StudentModel(
      firstname: _firstnameController.text,
      lastname: _lastnameController.text,
      age: int.tryParse(_ageController.text) ?? 0,
      className: _classController.text,
    );

    await studentController.createStudent(userToSave);

    _classController.clear();
    _ageController.clear();
    _lastnameController.clear();
    _firstnameController.clear();

    Get.back();

    Get.snackbar(
      'Information',
      "L'étudiant a bien été ajouter",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void addStudent(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Form(
                key: _keyForm,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Ajouter un étudiant",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),

                    // Champ pour le nom
                    TextFormField(
                      controller: _firstnameController,
                      decoration: InputDecoration(
                        hintText: "Nom",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF828282),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) => (value == null || value.isEmpty)
                          ? "Ce champ est obligatoire"
                          : null,
                      onChanged: (value) => firstname = value,
                    ),
                    SizedBox(height: 15),

                    // Champ pour le prénom
                    TextFormField(
                      controller: _lastnameController,
                      decoration: InputDecoration(
                        hintText: "Prénom",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF828282),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) => (value == null || value.isEmpty)
                          ? "Ce champ est obligatoire"
                          : null,
                      onChanged: (value) => lastname = value,
                    ),
                    SizedBox(height: 15),

                    // Champ pour l'âge
                    TextFormField(
                      controller: _ageController,
                      keyboardType:
                          TextInputType.number, // affiche le clavier numérique
                      decoration: InputDecoration(
                        hintText: "Âge",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF828282),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ce champ est obligatoire";
                        }
                        if (int.tryParse(value) == null) {
                          return "Veuillez entrer un nombre valide";
                        }
                        return null;
                      },
                      onChanged: (value) => age =
                          int.tryParse(value) ?? 0, // conversion sécurisée
                    ),
                    SizedBox(height: 15),

                    //Champ pour la classe
                    TextFormField(
                      controller: _classController,
                      decoration: InputDecoration(
                        hintText: "Classe",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF828282),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) => (value == null || value.isEmpty)
                          ? "Ce champ est obligatoire"
                          : null,
                      onChanged: (value) => className = value,
                    ),
                    SizedBox(height: 18),

                    // Bouton pour ajouter l'étudiant
                    OutlinedButton(
                      onPressed: () {
                        if (_keyForm.currentState!.validate()) {
                          saveStudentToFirebase();
                          Navigator.pop(context);
                        } else {
                          Get.snackbar(
                            'Information',
                            "Formulaire invalide",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Color(0xFF2FB98B),
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: Text(
                        "Ajouter",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget studentCard(StudentModel student) {
    return Container(
      margin: EdgeInsets.only(bottom: 23),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Color(0xFFFFFFFF),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 13),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Color(0xFFD9D9D9),
          child: Text(
            "${student.firstname[0]}${student.lastname[0]}",
            style: TextStyle(color: Colors.black, fontSize: 19),
          ),
        ),
        title: Text(
          "${student.firstname} ${student.lastname}",
          style: TextStyle(fontSize: 17),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 15),
        onTap: () => {
          /*  Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotePage(student: student),
            ),
          ) */
          Get.to(() => NotePage(student: student)),
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {return Scaffold(
      backgroundColor: Color(0xFFDBEEFF),
      body: Container(
        padding: EdgeInsets.only(top: 50, left: 15, right: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Etudiants",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 29,
                  height: 29,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () => addStudent(context),
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.add, size: 20),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              child: SearchBar(
                leading: Icon(Icons.search, color: Color(0xFF8C8C8C)),
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

            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 18),
                child: FutureBuilder<List<StudentModel>>(
                  future: studentController.getAllStudents(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Erreur lors de la récupération des étudiants",
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text("Aucun étudiant disponible"));
                    } else {
                      final allStudents = snapshot.data!;

                      // Appliquer le filtre seulement si l'utilisateur a tapé quelque chose
                      final displayedStudents = writtenText.isEmpty
                          ? allStudents
                          : allStudents.where((student) {
                              final fullName =
                                  "${student.firstname} ${student.lastname}"
                                      .toLowerCase();
                              return fullName.contains(
                                writtenText.toLowerCase(),
                              );
                            }).toList();

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: displayedStudents.length,
                        itemBuilder: (context, index) {
                          return studentCard(displayedStudents[index]);
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
