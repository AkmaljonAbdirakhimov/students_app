import 'package:students_app/models/group.dart';
import 'package:students_app/services/local_database/local_database.dart';

class GroupsDatabase {
  final _localDatabase = LocalDatabase();
  final _tableName = 'groups';

  Future<List<Group>> getGroups() async {
    final db = await _localDatabase.database;
    final rows = await db.query(_tableName);
    List<Group> groups = [];

    for (var row in rows) {
      groups.add(Group.fromMap(row));
    }

    return groups;
  }

  Future<void> addGroup(String title) async {
    final db = await _localDatabase.database;
    await db.insert(_tableName, {"title": title});
  }

  Future<void> editGroup(int id, String title) async {
    final db = await _localDatabase.database;
    await db.update(
      _tableName,
      {"title": title},
      where: "id = $id",
    );
  }

  Future<void> deleteGroup(int id) async {
    final db = await _localDatabase.database;
    await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
