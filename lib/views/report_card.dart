import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:student_notes/models/student_model.dart';
import 'package:student_notes/models/student_note.dart';
import 'package:student_notes/utils/average_extension.dart';

class ReportCard extends StatefulWidget {
  final StudentModel student;
  const ReportCard({super.key, required this.student});

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  late StudentNote studentNote;
  int studentRank = 0;

  // trouve dans studentNote l'item qui corespond a l'étudiant courant
  @override
  void initState() {
    super.initState();
    studentNote = studentNotes.firstWhere(
      (item) => item.students == widget.student,
    );
    // Calcul du rang de l'étudiant
    studentRank =
        studentNotes.classement().indexWhere(
          (sn) =>
              sn == studentNote, // <-- on compare directement les StudentNote
        ) +
        1;
    log("$studentRank");
  }

  double interro1 = 0;
  double interro2 = 0;
  double interro3 = 0;
  double dev1 = 0;
  double dev2 = 0;

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
    if (note % 1 == 0) {
      return note.toInt().toString(); // retirer le .0 si c'est un entier
    } else {
      // sinon on garde 2 chiffres après la virgule
      return note.toStringAsFixed(2);
    }
  }

  // +1 car index commence à 0

  @override
  Widget build(BuildContext context) {
    return Scaffold(/* 
      backgroundColor: Color(0xFFDBEEFF), */
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 15),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "NOM: ${widget.student.lastname}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  
                      Text(
                        "CLASSE: ${widget.student.className}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    "PRENOM: ${widget.student.firstname}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Âge: ${widget.student.age} ans",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
                  
              SizedBox(height: 25),
                  
              Text(
                "Bulletin de notes",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
                  
              SizedBox(height: 15),
                  
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(
                          label: Text(
                            "Matières",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Interrogations",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Devoirs",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Moyenne",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
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
                                          padding: EdgeInsetsGeometry.only(
                                            right: 5,
                                          ),
                                          child: noteContainer(
                                            convertInInt(note),
                                          ),
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
                                          padding: const EdgeInsets.only(
                                            right: 5,
                                          ),
                                          child: noteContainer(
                                            convertInInt(note),
                                          ),
                                        );
                                      }).toList()
                                    : [Text("N/A")],
                              ),
                            ),
                            DataCell(Text(convertInInt(ln.averageByLesson()))),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  
                  SizedBox(height: 17),
                  Text(
                    "Moyenne générale: ${convertInInt(studentNote.generalAverage())}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Rang: $studentRank ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  
                  SizedBox(height: 70),
                ],
              ),
                  
              /* Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Télécharger",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ), */
            ],
          ),
        Positioned(
          bottom: 20, // distance par rapport au bas
          right: 20,  // distance par rapport à la droite
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Télécharger",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        ]
      ),
    );
  }
}
