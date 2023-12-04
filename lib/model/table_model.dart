import 'package:hive/hive.dart';

part 'table_model.g.dart';

@HiveType(typeId: 2)
class TableModel {
  @HiveField(0)
  final String selected;
  @HiveField(1)
  final String time;
  @HiveField(2)
  final double length;
  @HiveField(3)
  final String location;

  TableModel(
      {required this.selected,
      required this.time,
      required this.length,
      required this.location});
}
