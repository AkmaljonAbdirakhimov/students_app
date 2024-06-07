import 'package:students_app/models/group.dart';
import 'package:students_app/services/local_database/groups_database.dart';

class GroupsViewmodel {
  final _groupsDatabase = GroupsDatabase();

  List<Group> _list = [];

  Future<List<Group>> get list async {
    _list = await _groupsDatabase.getGroups();
    return [..._list];
  }

  Future<void> addGroup(String title) async {
    await _groupsDatabase.addGroup(title);
  }

  Future<void> editGroup(int id, String title) async {
    await _groupsDatabase.editGroup(id, title);
  }

  Future<void> deleteGroup(int id) async {
    await _groupsDatabase.deleteGroup(id);
  }
}
