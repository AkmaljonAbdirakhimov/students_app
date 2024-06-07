import 'package:students_app/models/student.dart';
import 'package:students_app/services/local_database/local_database.dart';

class StudentsDatabase {
  final _localDatabase = LocalDatabase();
  final _tableName = 'students';

  Future<List<Student>> getStudents() async {
    final db = await _localDatabase.database;
//     String query = '''
//     SELECT *
//     FROM students
//     JOIN groups ON students.groupId = groups.id
// ''';
//     final rows = await db.rawQuery(query);
//     print(rows);
    final rows = await db.query(_tableName);
    List<Student> students = [];

    for (var row in rows) {
      students.add(Student.fromMap(row));
    }

    return students;
  }

  Future<List<Student>> getStudentsByGroup(int groupId) async {
    final db = await _localDatabase.database;
    final rows = await db.query(
      _tableName,
      where: "groupId = ?",
      whereArgs: [groupId],
    );

    List<Student> students = [];

    for (var row in rows) {
      students.add(Student.fromMap(row));
    }

    return students;
  }

  Future<void> addStudent(
    String fullname,
    int year_of_study,
    int mark,
    int groupId,
  ) async {
    final db = await _localDatabase.database;
    await db.insert(_tableName, {
      "fullname": fullname,
      "year_of_study": year_of_study,
      "mark": mark,
      "groupId": groupId,
    });
  }

  Future<void> close() async {
    final db = await _localDatabase.database;
    db.close();
  }

  // Future<void> editStudent(int id, String title) async {
  //   final db = await _localDatabase.database;
  //   await db.update(
  //     _tableName,
  //     {"title": title},
  //     where: "id = $id",
  //   );
  // }

  // Future<void> deleteStudent(int id) async {
  //   final db = await _localDatabase.database;
  //   await db.delete(
  //     _tableName,
  //     where: "id = ?",
  //     whereArgs: [id],
  //   );
  // }
}
