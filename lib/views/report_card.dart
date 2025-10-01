import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:student_notes/controllers/student_note_controller.dart';
import 'package:student_notes/models/student_model.dart';
import 'package:student_notes/models/student_note.dart';
import 'package:student_notes/utils/average_extension.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportCard extends StatefulWidget {
  final StudentModel student;
  const ReportCard({super.key, required this.student});

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  final StudentNoteController studentNoteController = StudentNoteController();
  StudentNote? studentNote;
  int studentRank = 0;
  bool isDownloading = false;

  Widget noteContainer(String note) {
    return Container(padding: EdgeInsets.all(8), child: Text(note));
  }

  String convertInInt(num note) {
    if (note % 1 == 0) {
      return note.toInt().toString();
    } else {
      return note.toStringAsFixed(2);
    }
  }

  Future<void> findStudentNote() async {
    final allstudentNotes = await studentNoteController.getAllStudentNotes();
    studentNote = allstudentNotes.firstWhere(
      (sn) => sn.students.lastname == widget.student.lastname,
      orElse: () => StudentNote(students: widget.student, lessonsAndNotes: []),
    );

    final classement = allstudentNotes.classement();
    studentRank =
        classement.indexWhere(
          (sn) => sn.students.lastname == widget.student.lastname,
        ) +
        1;

    setState(() {});
    log("Rang: $studentRank");
  }

  Future<void> downloadReportCard() async {
    if (studentNote == null) {
      Get.snackbar(
        'Erreur',
        'Aucune donnée disponible',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    setState(() {
      isDownloading = true;
    });

    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Text(
                    'BULLETIN DE NOTES',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Container(
                  padding: pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey),
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'NOM: ${widget.student.lastname}',
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            'CLASSE: ${widget.student.className}',
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        'PRÉNOM: ${widget.student.firstname}',
                        style: pw.TextStyle(fontSize: 14),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        'ÂGE: ${widget.student.age} ans',
                        style: pw.TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Table.fromTextArray(
                  headerStyle: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                  ),
                  cellStyle: pw.TextStyle(fontSize: 11),
                  headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
                  cellAlignment: pw.Alignment.center,
                  headers: ['Matières', 'Interrogations', 'Devoirs', 'Moyenne'],
                  data: studentNote!.lessonsAndNotes.map((ln) {
                    return [
                      ln.lessons.lessonname,
                      ln.interrogation.map((e) => convertInInt(e)).join(', '),
                      ln.devoir.map((e) => convertInInt(e)).join(', '),
                      convertInInt(ln.averageByLesson()),
                    ];
                  }).toList(),
                ),
                pw.SizedBox(height: 20),
                pw.Container(
                  padding: pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey200,
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'MOYENNE GÉNÉRALE: ${convertInInt(studentNote!.generalAverage())}',
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        'RANG: $studentRank',
                        style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );

      // Chemin direct sans plugin
      final downloadsPath = '/storage/emulated/0/Download';
      final fileName =
          'bulletin_${widget.student.firstname}_${widget.student.lastname}_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File('$downloadsPath/$fileName');

      await file.writeAsBytes(await pdf.save());

      Get.snackbar(
        'Succès',
        'Bulletin téléchargé: $fileName',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
      );

      log('PDF sauvegardé: ${file.path}');
    } catch (e) {
      log('Erreur lors du téléchargement: $e');
      Get.snackbar(
        'Erreur',
        'Impossible de télécharger le bulletin: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        isDownloading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    findStudentNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: studentNote == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView(
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
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Âge: ${widget.student.age} ans",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Text(
                        "Bulletin de notes",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 15),
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
                          rows: studentNote!.lessonsAndNotes.map((ln) {
                            return DataRow(
                              cells: [
                                DataCell(Text(ln.lessons.lessonname)),
                                DataCell(
                                  Row(
                                    children: ln.interrogation.isNotEmpty
                                        ? ln.interrogation
                                              .map(
                                                (note) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        right: 5,
                                                      ),
                                                  child: noteContainer(
                                                    convertInInt(note),
                                                  ),
                                                ),
                                              )
                                              .toList()
                                        : [Text("N/A")],
                                  ),
                                ),
                                DataCell(
                                  Row(
                                    children: ln.devoir.isNotEmpty
                                        ? ln.devoir
                                              .map(
                                                (note) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        right: 5,
                                                      ),
                                                  child: noteContainer(
                                                    convertInInt(note),
                                                  ),
                                                ),
                                              )
                                              .toList()
                                        : [Text("N/A")],
                                  ),
                                ),
                                DataCell(
                                  Text(convertInInt(ln.averageByLesson())),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 17),
                      Text(
                        "Moyenne générale: ${convertInInt(studentNote!.generalAverage())}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Rang: $studentRank",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: InkWell(
                      onTap: isDownloading ? null : downloadReportCard,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: isDownloading ? Colors.grey : Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isDownloading)
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),
                            if (isDownloading) SizedBox(width: 10),
                            Text(
                              isDownloading
                                  ? "Téléchargement..."
                                  : "Télécharger",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
