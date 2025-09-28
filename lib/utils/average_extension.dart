
import 'package:student_notes/models/lesson_and_note.dart';
import 'package:student_notes/models/lesson_model.dart';
import 'package:student_notes/models/student_note.dart';

extension LessonAndNotesExtension on LessonAndNotes {
  double averageByLesson() {
    //calculer la moyenne des interrogations par matière
    double interrogationAverage = interrogation.isEmpty
        ? 0
        : interrogation.reduce((a, b) => a + b) / interrogation.length;

    // calculer la moyenne par matière
    double average = devoir.isEmpty?0:( devoir.reduce((a, b) => a+b) + interrogationAverage)/3;
    return average;
  }
}

extension StudentNoteListExtension on List<StudentNote> {
  // Cette fonction calcule la moyenne de la classe pour une matière donnée
  double classAverageByLesson(LessonModel lesson) {
    // Si la liste des étudiants est vide, on retourne directement 0
    if (isEmpty) return 0;

    double sumOfAverages = 0; // Variable pour stocker la somme des moyennes de chaque étudiant dans cette matière

    // Boucle sur chaque étudiant de la liste
    for (var studentNote in this) {//  this représente deja la liste
      // On récupère la note de l'étudiant pour la matière spécifiée
      final lessonNote = studentNote.lessonsAndNotes.firstWhere(
        (ln) => ln.lessons.lessonname == lesson.lessonname,
        orElse: () => LessonAndNotes(lessons: lesson),
      );

      // On calcule la moyenne de cette matière pour l'étudiant courant
      double studentAverage = lessonNote.averageByLesson();

      // On ajoute cette moyenne à la somme totale
      sumOfAverages += studentAverage;
    }

    // Division par le nombre total d'étudiants (length = studentNotes.lenght a cause "this")
    double averageInThisLesson = sumOfAverages / length; // on peut mettre this.lengh si on veut
    return averageInThisLesson;
  }
}


extension StudentNoteExtension on StudentNote {
  double generalAverage() {
  if (lessonsAndNotes.isEmpty) return 0;
  double sumOfAverages = 0;
  for (var ln in lessonsAndNotes) {
    sumOfAverages += ln.averageByLesson();
  }
  return sumOfAverages / lessonsAndNotes.length;
}
}

extension ClassementExtension on List<StudentNote> {

  // Cette fonction retourne la liste des étudiants triée en fonction de leur moyenne générale (du plus fort au plus faible)
  List<StudentNote> classement() {
    
    // On crée une COPIE de la liste actuelle pour éviter de modifier la liste d'origine .
    List<StudentNote> sortedList = List.from(this);

    // On trie la liste copiée avec .sort()
    // Ici, on compare la moyenne générale des deux étudiants :
    // - b.generalAverage() : moyenne de l’étudiant b
    // - a.generalAverage() : moyenne de l’étudiant a
    // On fait "b.compareTo(a)" pour que le tri soit décroissant
    // (plus grande moyenne en premier).
    sortedList.sort((a, b) => 
      b.generalAverage().compareTo(a.generalAverage())
    );

    // On retourne la liste triée
    return sortedList;
  }
}

