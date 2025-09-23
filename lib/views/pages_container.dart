import 'package:flutter/material.dart';
import 'package:student_notes/views/home.dart';
import 'package:student_notes/views/lesson.dart';
import 'package:student_notes/views/report_card.dart';
import 'package:student_notes/views/student.dart';

class PagesContainer extends StatefulWidget {
  const PagesContainer({super.key});

  @override
  State<PagesContainer> createState() => _PagesContainerState();
}

class _PagesContainerState extends State<PagesContainer> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      Home(),
      Student(),
      Lesson(),
      ReportCard()
    ];
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Color(
          0xFF000000,
        ),
        unselectedItemColor: Color(0xFF8C8C8C),
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Etudiants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Matières',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.workspace_premium),
            label: 'Bulletin',
          ),
        ],
      ),
    );
  }
}