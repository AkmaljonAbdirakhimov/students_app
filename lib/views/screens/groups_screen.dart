import 'package:flutter/material.dart';
import 'package:students_app/models/group.dart';
import 'package:students_app/view_models/groups_viewmodel.dart';
import 'package:students_app/view_models/students_viewmodel.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final studentsViewModel = StudentsViewmodel();
  final groupsViewModel = GroupsViewmodel();
  List<Group> groups = [];

  @override
  void initState() {
    super.initState();

    getGroups();
  }

  void getGroups() async {
    groups = await groupsViewModel.list;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: groups.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: groups.map((group) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text("Guruh-${group.title}"),
              );
            }).toList(),
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
            child: TabBarView(
              children: groups.map((group) {
                return FutureBuilder(
                    future: studentsViewModel.getStudentsByGroup(group.id),
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
                                      "${group.title}-Guruh: ${students[index].year_of_study}-kurs",
                                    ),
                                  ),
                                );
                              },
                            );
                    });
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
