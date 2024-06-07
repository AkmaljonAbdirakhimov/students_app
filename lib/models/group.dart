class Group {
  final int id;
  String title;

  Group({
    required this.id,
    required this.title,
  });

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(id: map['id'], title: map['title']);
  }
}
