import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_notes/controllers/lesson_controller.dart';
import 'package:student_notes/models/lesson_model.dart';

class Lesson extends StatefulWidget {
  const Lesson({super.key});

  @override
  State<Lesson> createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  String lessonname = "";
  String imageUrl = "";

  final _lessonController = TextEditingController();
  final _imageController = TextEditingController();

  final _keyForm = GlobalKey<FormState>();

  LessonController lessonController = LessonController();

  void saveLessonToFirebase() async {
    LessonModel lessonToSave = LessonModel(
      lessonname: _lessonController.text,
      imageUrl: _imageController.text,
    );

    await lessonController.createLesson(lessonToSave);

    _lessonController.clear();
    _imageController.clear();

    Get.back();

    Get.snackbar(
      'Information',
      "La matière a bien été ajouter",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

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

                    //Champ pour l'image
                    TextFormField(
                      controller: _imageController,
                      decoration: InputDecoration(
                        hintText: "Url de l'image",
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
                      onChanged: (value) => imageUrl = value,
                    ),
                    SizedBox(height: 18),

                    // Bouton pour ajouter l'étudiant
                    OutlinedButton(
                      onPressed: () {
                        if (_keyForm.currentState!.validate()) {
                          saveLessonToFirebase();
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

  /* Future<void> loadRecipesFromFirebase() async {
    try {
      log("Récupération des recettes depuis Firebase...");
      List<Recipe> recipes = await recipeController.getAllRecipes();
      setState(() {
        firebaseRecipes = recipes;
      });
      log("${recipes.length} recettes récupérées avec succès");
    } catch (e) {
      log("Erreur lors de la récupération des recettes: $e");
    }
  } */

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

      body: Container(
        padding: EdgeInsets.symmetric(horizontal:8, vertical: 20),
        child: FutureBuilder<List<LessonModel>>(
          
          future: lessonController
              .getAllLessons(), // récupère les matières depuis Firestore
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Erreur lors de la récupération des matières"),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("Aucune matière disponible"));
            } else {
              final lessonsFromFirebase = snapshot.data!;
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                itemCount: lessonsFromFirebase.length,
                itemBuilder: (context, index) {
                  return lessonContainer(lessonsFromFirebase[index]);
                },
              );
            }
          },
        ),
      ),
    );
    /* ListView(
        padding: EdgeInsets.symmetric(horizontal:15, vertical: 20),
        children: lessons.map((lesson) {
          return lessonContainer(lesson);
        }).toList(),
      ),
    ); */
  }
}
