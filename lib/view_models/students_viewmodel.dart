import 'package:students_app/models/student.dart';
import 'package:students_app/services/local_database/students_database.dart';

class StudentsViewmodel {
  final _studentsDatabase = StudentsDatabase();

  List<Student> _list = [];

  Future<List<Student>> get list async {
    _list = await _studentsDatabase.getStudents();
    return [..._list];
  }

  Future<List<Student>> getStudentsByGroup(int groupId) async {
    return await _studentsDatabase.getStudentsByGroup(groupId);
  }

  Future<void> addStudent(
    String fullname,
    int year_of_study,
    int mark,
    int groupId,
  ) async {
    await _studentsDatabase.addStudent(fullname, year_of_study, mark, groupId);
  }

  Future<void> closeDB() async {
    _studentsDatabase.close();
  }

  // Future<void> editStudent(int id, String title) async {
  //   await _studentsDatabase.editStudent(id, title);
  // }

  // Future<void> deleteStudent(int id) async {
  //   await _studentsDatabase.deleteStudent(id);
  // }
}
