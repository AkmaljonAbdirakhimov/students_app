import 'package:flutter/material.dart';
import 'package:students_app/views/screens/groups_screen.dart';
import 'package:students_app/views/screens/manage_student_screen.dart';
import 'package:students_app/views/screens/marks_screen.dart';
import 'package:students_app/views/screens/students_screen.dart';
import 'package:students_app/views/widgets/groups_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> screens = [
    const StudentsScreen(),
    const GroupsScreen(),
    const MarksScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    print("Home Screen");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bosh Sahifa"),
        actions: [
          IconButton(
            onPressed: () async {
              final response = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const ManageStudentScreen();
                  },
                ),
              );
              if (response == true) {
                setState(() {});
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: IndexedStack(
          index: selectedIndex,
          children: screens,
        ),
      ),
      floatingActionButton: SizedBox(
        child: FilledButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (ctx) {
                return const GroupsModal();
              },
            );
          },
          child: const Text("GURUH QO'SHISH"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) {
          selectedIndex = value;
          setState(() {});
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Bosh sahifa",
          ),
          NavigationDestination(
            icon: Icon(Icons.category),
            label: "Guruhlar",
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle),
            label: "Baholar",
          ),
        ],
      ),
    );
  }
}
