import 'package:flutter/material.dart';
import 'package:student_notes/models/lesson_model.dart';
import 'package:student_notes/models/student_model.dart';
import 'package:student_notes/models/student_note.dart';

class NotePage extends StatefulWidget {
  final StudentModel student;
  const NotePage({super.key, required this.student});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late StudentNote studentNote;

  // trouve dans studentNote l'item qui corespond a l'étudiant courant
  @override
  void initState() {
    super.initState();
    studentNote = studentNotes.firstWhere(
      (item) => item.students == widget.student,
    );
  }

  int interro1 = 00;
  int interro2 = 00;
  int interro3 = 00;
  int dev1 = 00;
  int dev2 = 00;

  final _interro1Controller = TextEditingController();
  final _interro2Controller = TextEditingController();
  final _interro3Controller = TextEditingController();
  final _dev1Controller = TextEditingController();
  final _dev2Controller = TextEditingController();

  LessonModel? selectedLesson;

  final _keyForm = GlobalKey<FormState>();

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

                    // Champ pour le nom
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
                          ), // utilise ton nom de matière
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
                              TextFormField(
                                controller: _interro1Controller,
                                keyboardType: TextInputType
                                    .number, // affiche le clavier numérique
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
                                  if (int.tryParse(value) == null) {
                                    return "Veuillez entrer un nombre valide";
                                  }
                                  return null;
                                },
                                onChanged: (value) =>
                                    interro1 = int.tryParse(value) ?? 00,
                              ),

                              SizedBox(height: 10),

                              TextFormField(
                                controller: _interro2Controller,
                                keyboardType: TextInputType
                                    .number, // affiche le clavier numérique
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
                                  if (int.tryParse(value) == null) {
                                    return "Veuillez entrer un nombre valide";
                                  }
                                  return null;
                                },
                                onChanged: (value) =>
                                    interro2 = int.tryParse(value) ?? 00,
                              ),

                              SizedBox(height: 10),

                              TextFormField(
                                controller: _interro3Controller,
                                keyboardType: TextInputType
                                    .number, // affiche le clavier numérique
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
                                  if (int.tryParse(value) == null) {
                                    return "Veuillez entrer un nombre valide";
                                  }
                                  return null;
                                },
                                onChanged: (value) =>
                                    interro3 = int.tryParse(value) ?? 0,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 15),

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
                              TextFormField(
                                controller: _dev1Controller,
                                keyboardType: TextInputType
                                    .number, // affiche le clavier numérique
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
                                  if (int.tryParse(value) == null) {
                                    return "Veuillez entrer un nombre valide";
                                  }
                                  return null;
                                },
                                onChanged: (value) =>
                                    dev1 = int.tryParse(value) ?? 0,
                              ),

                              SizedBox(height: 10),
                              
                              TextFormField(
                                controller: _dev2Controller,
                                keyboardType: TextInputType
                                    .number, // affiche le clavier numérique
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
                                  if (int.tryParse(value) == null) {
                                    return "Veuillez entrer un nombre valide";
                                  }
                                  return null;
                                },
                                onChanged: (value) =>
                                    dev2 = int.tryParse(value) ?? 0,
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
                          print(
                            "Notes ajouter pour ${selectedLesson?.lessonname}: $interro1 $interro2, $interro3, $dev1, $dev2",
                          );
                          // Vider les champs après l'ajout
                          _interro1Controller.clear();
                          _interro2Controller.clear();
                          _interro3Controller.clear();
                          _dev1Controller.clear();
                          _dev2Controller.clear();

                          //réinitialiser les variables
                          interro1 = 00;
                          interro2 = 00;
                          interro3 = 00;
                          dev1 = 00;
                          dev2 = 00;
                          selectedLesson = null;

                          Navigator.pop(context);
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

  /* Widget? noteContainer(){
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.3,

    );

  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Notes ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
        ),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
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
                      offset: Offset(0, 3), // changes position of shadow
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

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView(
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
                          "Interro",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Devoirs",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows: studentNote.lessonsAndNotes.map((ln) {
                      return DataRow(
                        cells: [
                          DataCell(Text(ln.lessons.lessonname)),
                          DataCell(
                            Text(
                              ln.notes.isNotEmpty
                                  ? ln.notes
                                        .take(3)
                                        .map((note) => note.toString())
                                        .join(" , ")
                                  : "N/A",
                            ),
                          ),
                          DataCell(
                            Text(
                              ln.notes.length > 2
                                  ? ln.notes
                                        .skip(3)
                                        .map((note) => note.toString())
                                        .join(" , ")
                                  : "N/A",
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
