
class UserDOB{
  final DateTime date;
  final int age;
  UserDOB({
    required this.date,
    required this.age,
  });

  factory UserDOB.fromMap(Map<String, dynamic> json){
    final date = json['date'];
    return UserDOB(
            date: DateTime.parse(date),
            age: json['age'],
          );
  }
}