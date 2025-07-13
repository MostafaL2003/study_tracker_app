import 'package:hive/hive.dart';

part 'subject_model.g.dart';

@HiveType(typeId: 0)
class Subject extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  bool timerStart;

  @HiveField(2)
  int timeSpent;

  @HiveField(3)
  int timeGoal;

  Subject({
    required this.name,
    required this.timerStart,
    required this.timeSpent,
    required this.timeGoal,
  });
}
