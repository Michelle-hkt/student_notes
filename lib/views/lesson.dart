import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:student_notes/models/lesson_model.dart';

class Lesson extends StatefulWidget {
  const Lesson({super.key});

  @override
  State<Lesson> createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  String lessonname = "";

  final _lessonController = TextEditingController();

  final _keyForm = GlobalKey<FormState>();

  void addLesson(BuildContext context) {
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
                      "Ajouter une matière",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),

                    //Champ pour la matière
                    TextFormField(
                      controller: _lessonController,
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
                      onChanged: (value) => lessonname = value,
                    ),
                    SizedBox(height: 18),

                    // Bouton pour ajouter l'étudiant
                    OutlinedButton(
                      onPressed: () {
                        if (_keyForm.currentState!.validate()) {
                          log("Ajouter la Matière: $lessonname");
                          // Vider le champs après l'ajout
                          _lessonController.clear();

                          //réinitialiser la variable
                          lessonname = "";

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

  Widget lessonContainer(LessonModel lesson) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.3,

      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(lesson.imageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topRight,
            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
          ),
        ),
        child: Text(
          lesson.lessonname,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDBEEFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Matières",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15),
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
              onPressed: () => addLesson(context),
              padding: EdgeInsets.zero,
              icon: Icon(Icons.add, size: 20),
            ),
          ),
        ],
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(horizontal:15, vertical: 20),
        children: lessons.map((lesson) {
          return lessonContainer(lesson);
        }).toList(),
      ),
    );
  }
}
