class Student {
  final int id;
  String fullname;
  int year_of_study;
  int mark;
  int groupId;

  Student({
    required this.id,
    required this.fullname,
    required this.year_of_study,
    required this.mark,
    required this.groupId,
  });

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      fullname: map['fullname'],
      year_of_study: map['year_of_study'],
      mark: map['mark'],
      groupId: map['groupId'],
    );
  }
}
