import 'package:flutter/material.dart';
import 'package:students_app/view_models/groups_viewmodel.dart';

class GroupsModal extends StatefulWidget {
  const GroupsModal({super.key});

  @override
  State<GroupsModal> createState() => _GroupsModalState();
}

class _GroupsModalState extends State<GroupsModal> {
  final groupNameController = TextEditingController();
  final groupsViewModel = GroupsViewmodel();

  void addGroup() async {
    if (groupNameController.text.trim().isNotEmpty) {
      await groupsViewModel.addGroup(groupNameController.text);
      groupNameController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ortga"),
          ),
          TextField(
            controller: groupNameController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: "Guruh nomi",
              suffixIcon: IconButton(
                onPressed: addGroup,
                icon: const Icon(
                  Icons.add,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Guruhlar",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: groupsViewModel.list,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final groups = snapshot.data;
                return groups == null || groups.isEmpty
                    ? const Center(
                        child: Text("Guruhlar mavjud emas"),
                      )
                    : ListView.builder(
                        itemCount: groups.length,
                        itemBuilder: (ctx, index) {
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              title: Text(groups[index].title),
                            ),
                          );
                        },
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
