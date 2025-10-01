import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:student_notes/controllers/student_note_controller.dart';
import 'package:student_notes/models/lesson_and_note.dart';
import 'package:student_notes/models/lesson_model.dart';
import 'package:student_notes/models/student_model.dart';
import 'package:student_notes/models/student_note.dart';
import 'package:student_notes/views/report_card.dart';

class NotePage extends StatefulWidget {
  final StudentModel student;
  const NotePage({super.key, required this.student});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {


  @override
  void initState() {
    super.initState();
    
  }
   


  double interro1 = 0;
  double interro2 = 0;
  double interro3 = 0;
  double dev1 = 0;
  double dev2 = 0;

  final _interro1Controller = TextEditingController();
  final _interro2Controller = TextEditingController();
  final _interro3Controller = TextEditingController();
  final _dev1Controller = TextEditingController();
  final _dev2Controller = TextEditingController();

  LessonModel? selectedLesson;

  final _keyForm = GlobalKey<FormState>();

  StudentNoteController studentNoteController = StudentNoteController();

  void saveStudentNotesToFirebase() async {
  // 1. Construire un nouvel objet LessonAndNotes
  LessonAndNotes lessonAndNotes = LessonAndNotes(
    lessons: selectedLesson!, // choisi dans le Dropdown
    interrogation: [interro1, interro2, interro3]
        .where((note) => note > 0)
        .toList(), // on garde que les notes saisies
    devoir: [dev1, dev2].where((note) => note > 0).toList(),
  );

  // 2. Construire un StudentNote (lié à l’étudiant courant)
  StudentNote studentNoteToSave = StudentNote(
    students: widget.student,
    lessonsAndNotes: [lessonAndNotes], // ici on sauvegarde la matière choisie + les notes
  );

  // 3. Appeler ton controller pour envoyer dans Firestore
  await studentNoteController.createStudentNote(studentNoteToSave);

  // 4. Nettoyer les champs
  _interro1Controller.clear();
  _interro2Controller.clear();
  _interro3Controller.clear();
  _dev1Controller.clear();
  _dev2Controller.clear();
  selectedLesson = null;

  // 5. Fermer la pop-up et notifier
  Get.back();
  Get.snackbar(
    'Information',
    "Les notes ont bien été enregistrées",
    snackPosition: SnackPosition.BOTTOM,
  );
}


  // ajout de note
  void addNote(BuildContext context) {
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
                      "Ajout de note ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),

                    // Champ type select pour le nom de la matière
                    DropdownButtonFormField<LessonModel>(
                      value: selectedLesson,
                      decoration: InputDecoration(
                        hintText: "Choisir une Matière",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF828282),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items: lessons.map((lesson) {
                        return DropdownMenuItem(
                          value: lesson,
                          child: Text(
                            lesson.lessonname,
                          ), 
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedLesson = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? "Ce champ est obligatoire" : null,
                    ),
                    SizedBox(height: 15),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "Interrogations",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10),

                              //Interrogation note1
                              TextFormField(
                                controller: _interro1Controller,
                                keyboardType: TextInputType
                                    .numberWithOptions(decimal: true), // affiche le clavier numérique
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))],
                                decoration: InputDecoration(
                                  hintText: "note 1",
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
                                  final number = double.tryParse(value);
                                  if (number == null) {
                                    return "Veuillez entrer un nombre valide";
                                  }
                                  if(number < 0 || number > 20) {
                                    return "Entre 0 et 20";
                                  }
                                  return null;
                                },
                                onChanged: (value) =>
                                    interro1 = double.tryParse(value) ?? 0,
                              ),

                              SizedBox(height: 10),

                              // Interrogation note2
                              TextFormField(
                                controller: _interro2Controller,
                                keyboardType: TextInputType
                                    .numberWithOptions(decimal: true), // affiche le clavier numérique
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))],
                                decoration: InputDecoration(
                                  hintText: "note 2",
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
                                  final number = double.tryParse(value);
                                  if (number == null) {
                                    return "Veuillez entrer un nombre valide";
                                  }
                                  if(number < 0 || number > 20) {
                                    return "Entre 0 et 20";
                                  }
                                  return null;
                                },
                                onChanged: (value) =>
                                    interro2 = double.tryParse(value) ?? 00,
                              ),

                              SizedBox(height: 10),
                              
                              //Interrogation note3
                              TextFormField(
                                controller: _interro3Controller,
                                keyboardType: TextInputType
                                    .numberWithOptions(decimal: true), // affiche le clavier numérique
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))],
                                decoration: InputDecoration(
                                  hintText: "note 3",
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
                                  final number = double.tryParse(value);
                                  if (number == null) {
                                    return "Veuillez entrer un nombre valide";
                                  }
                                  if(number < 0 || number > 20) {
                                    return "Entre 0 et 20";
                                  }
                                  return null;
                                },
                                onChanged: (value) =>
                                    interro3 =double.tryParse(value) ?? 0,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 15),

                        // DEVOIR
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "Devoirs",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10),

                              //Devoir1
                              TextFormField(
                                controller: _dev1Controller,
                                keyboardType: TextInputType
                                    .numberWithOptions(decimal: true), // affiche le clavier numérique
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))],
                                decoration: InputDecoration(
                                  hintText: "note 1",
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
                                  final number = double.tryParse(value);
                                  if (number == null) {
                                    return "Veuillez entrer un nombre valide";
                                  }
                                  if(number < 0 || number > 20) {
                                    return "Entre 0 et 20";
                                  }
                                  return null;
                                },
                                onChanged: (value) =>
                                    dev1 = double.tryParse(value) ?? 0,
                              ),

                              SizedBox(height: 10),

                              // Devoir note2
                              TextFormField(
                                controller: _dev2Controller,
                                keyboardType: TextInputType
                                    .numberWithOptions(decimal: true), // affiche le clavier numérique
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))],
                                decoration: InputDecoration(
                                  hintText: "note 2",
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
                                  final number = double.tryParse(value);
                                  if (number == null) {
                                    return "Veuillez entrer un nombre valide";
                                  }
                                  if(number < 0 || number > 20) {
                                    return "Entre 0 et 20";
                                  }
                                  return null;
                                },
                                onChanged: (value) =>
                                    dev2 = double.tryParse(value) ?? 0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 18),

                    // Bouton pour ajouter l'étudiant
                    OutlinedButton(
                      onPressed: () {
                        if (_keyForm.currentState!.validate()) {
                          saveStudentNotesToFirebase();
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

  // le container de chaque note
  Widget noteContainer(String note) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.transparent),
      child: Text(note),
    );
  }

// fonction pour convertir les double auyant un .0 en entier
String convertInInt(num note) {
  if(note % 1 == 0){
    return note.toInt().toString(); // retirer le .0 si c'est un entier
  }else{
    return note.toString();
  }
}


  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(0xFFDBEEFF),
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        'Notes',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      ),
    ),
    body: FutureBuilder<List<StudentNote>>(
      future: studentNoteController.getAllStudentNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Erreur lors de la récupération des notes"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("Aucune note disponible"));
        } else {
          // On récupère toutes les notes
          final allstudentNote = snapshot.data!;
          // On filtre pour garder uniquement celles de l’étudiant courant
          final studentNote = allstudentNote.firstWhere(
            (item) => item.students.lastname == widget.student.lastname,
            orElse: () => StudentNote(students: widget.student, lessonsAndNotes: []),
          );

          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "NOM: ${widget.student.lastname}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "PRENOM: ${widget.student.firstname}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () => addNote(context),
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.add, size: 20),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15),

              // Tableau des notes
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text("Matières", style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text("Interrogations", style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text("Devoirs", style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: studentNote.lessonsAndNotes.map((ln) {
                    return DataRow(
                      cells: [
                        DataCell(Text(ln.lessons.lessonname)),
                        DataCell(
                          Row(
                            children: ln.interrogation.isNotEmpty
                                ? ln.interrogation.map((note) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: noteContainer(convertInInt(note)),
                                    );
                                  }).toList()
                                : [Text("N/A")],
                          ),
                        ),
                        DataCell(
                          Row(
                            children: ln.devoir.isNotEmpty
                                ? ln.devoir.map((note) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: noteContainer(convertInInt(note)),
                                    );
                                  }).toList()
                                : [Text("N/A")],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 30),

              Center(
                child: InkWell(
                  onTap: () {
                    Get.to(() => ReportCard(student: widget.student));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Générer un bulletin",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )
            ],
          );
        }
      },
    ),
  );
}

  }

