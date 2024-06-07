import 'package:flutter/material.dart';
import 'package:students_app/models/group.dart';
import 'package:students_app/view_models/groups_viewmodel.dart';
import 'package:students_app/view_models/students_viewmodel.dart';

class ManageStudentScreen extends StatefulWidget {
  const ManageStudentScreen({super.key});

  @override
  State<ManageStudentScreen> createState() => _ManageStudentScreenState();
}

class _ManageStudentScreenState extends State<ManageStudentScreen> {
  final studentsViewModel = StudentsViewmodel();
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic> studentData = {};
  List<Group> groups = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    getGroups();
  }

  void getGroups() async {
    final groupsViewModel = GroupsViewmodel();
    groups = await groupsViewModel.list;
    setState(() {});
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      //? Talaba Qo'shish
      setState(() {
        isLoading = true;
      });
      studentsViewModel
          .addStudent(
        studentData['fullname'],
        int.parse(studentData['year_of_study']),
        int.parse(studentData['mark']),
        studentData['groupId'],
      )
          .then((_) {
        Navigator.pop(context, true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Talaba Qo'shish"),
      ),
      body: isLoading
          ? const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: LinearProgressIndicator(),
              ),
            )
          : Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Ism va Familiya",
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Iltimos ism va familiya kiriting";
                      }

                      return null;
                    },
                    onSaved: (newValue) {
                      studentData['fullname'] = newValue;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nechinchi kurs",
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Nechinchi kursda o'qiysiz, yozing!";
                      }

                      return null;
                    },
                    onSaved: (newValue) {
                      studentData['year_of_study'] = newValue;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Bahoyingiz nechchi",
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Nechchi bahoga o'qiysiz, yozing!";
                      }

                      return null;
                    },
                    onSaved: (newValue) {
                      studentData['mark'] = newValue;
                    },
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Bahoyingiz nechchi",
                    ),
                    value: studentData['groupId'],
                    hint: const Text("Guruhni tanlang"),
                    items: groups.map((group) {
                      return DropdownMenuItem(
                        value: group.id,
                        child: Text('Guruh - ${group.title}'),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return "Iltimos guruhingizni tanglang";
                      }

                      return null;
                    },
                    onChanged: (newValue) {
                      studentData['groupId'] = newValue;
                    },
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: submit,
                    child: const Text("QO'SHISH"),
                  ),
                ],
              ),
            ),
    );
  }
}
