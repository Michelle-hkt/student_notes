import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_notes/controllers/student_note_controller.dart';
import 'package:student_notes/models/lesson_model.dart';
import 'package:student_notes/models/student_note.dart';
import 'package:student_notes/views/lesson.dart';
import 'package:student_notes/views/rank_page.dart';
import 'package:student_notes/views/search.dart';
import 'package:student_notes/views/student.dart';
import 'package:student_notes/utils/average_extension.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final StudentNoteController studentNoteController = StudentNoteController();
  List<StudentNote> studentNotesList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudentNotes();
  }

  void fetchStudentNotes() async {
    final notes = await studentNoteController.getAllStudentNotes();
    setState(() {
      studentNotesList = notes;
      isLoading = false;
    });
  }

  Widget buildMenuCard(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 30, color: Colors.blue),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  String convertInInt(num note) {
    if (note % 1 == 0) {
      return note.toInt().toString();
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
        title: const Text("Statistiques de la classe"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              child: ListView(
                padding: const EdgeInsets.all(17),
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: SizedBox(
                      height: 250,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 20,
                          barTouchData: BarTouchData(
                            enabled: true,
                            touchTooltipData: BarTouchTooltipData(
                              getTooltipItem:
                                  (group, groupIndex, rod, rodIndex) {
                                    final lesson = lessons[group.x.toInt()];
                                    return BarTooltipItem(
                                      lesson.lessonname, // nom de la matière
                                      const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                            ),
                          ),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget:
                                    (double value, TitleMeta meta) {
                                      int index = value.toInt();
                                      if (index < lessons.length) {
                                        double average = studentNotesList
                                            .classAverageByLesson(
                                              lessons[index],
                                            );
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              convertInInt(average),
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ), // moyenne sous la barre
                                          ],
                                        );
                                      }
                                      return const Text('');
                                    },
                                interval: 1,
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          gridData: FlGridData(show: false),
                          barGroups: List.generate(lessons.length, (index) {
                            double average = studentNotesList
                                .classAverageByLesson(lessons[index]);
                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: average,
                                  color: Colors.blue,
                                  width: 20,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      InkWell(
                        child: buildMenuCard("Etudiants", Icons.group),
                        onTap: () {
                          Get.to(() => const Student());
                        },
                      ),
                      InkWell(
                        child: buildMenuCard("Matières", Icons.book),
                        onTap: () {
                          Get.to(() => const Lesson());
                        },
                      ),
                      InkWell(
                        child: buildMenuCard("Classement", Icons.leaderboard),
                        onTap: () {
                          Get.to(() => const RankPage());
                        },
                      ),
                      InkWell(
                        child: buildMenuCard("Bulletins", Icons.assignment),
                        onTap: () {
                          Get.to(() => const Search());
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        const Text(
                          "Moyennes par matières",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Column(
                          children: lessons.map((lesson) {
                            double average = studentNotesList
                                .classAverageByLesson(lesson);

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    lesson.lessonname,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    convertInInt(average),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
