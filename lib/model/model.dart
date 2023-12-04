import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 1)
class SubjectModel {
  @HiveField(0)
  final String subject;
  @HiveField(1)
  final String present;
  @HiveField(2)
  final String total;

  SubjectModel(
      {required this.subject, required this.present, required this.total});
}
