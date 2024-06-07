import 'package:flutter/material.dart';
import 'package:students_app/view_models/students_viewmodel.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final studentsViewModel = StudentsViewmodel();

  @override
  void dispose() {
    studentsViewModel.closeDB();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Student Screen");

    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: "Izlash",
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Talabalar",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: FutureBuilder(
              future: studentsViewModel.list,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final students = snapshot.data;
                return students == null || students.isEmpty
                    ? const Center(
                        child: Text("Talabalar mavjud emas"),
                      )
                    : ListView.builder(
                        itemCount: students.length,
                        itemBuilder: (ctx, index) {
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: ListTile(
                              title: Text(students[index].fullname),
                              subtitle: Text(
                                "${students[index].year_of_study}-kurs",
                              ),
                            ),
                          );
                        },
                      );
              }),
        ),
      ],
    );
  }
}
