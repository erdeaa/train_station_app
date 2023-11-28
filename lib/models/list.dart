import 'package:hive/hive.dart';

part 'list.g.dart';

@HiveType(typeId: 0)
class ListModel extends HiveObject{
  @HiveField(0)
  String title;
  @HiveField(1)
  bool isDone;
  @HiveField(2)
  String? destination;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? imageUrl;

  ListModel({
    required this.title,
    this.isDone = false,
    this.destination,
    this.description,
    this.imageUrl,
  });
}
