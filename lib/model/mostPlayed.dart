import 'package:hive/hive.dart';
part 'mostPlayed.g.dart';

@HiveType(typeId: 3)
class MostPlayed {
  @HiveField(0)
  String songname;
  @HiveField(1)
  String artist;
  @HiveField(2)
  int duration;
  @HiveField(3)
  String songurl;
  @HiveField(4)
  int count;
  @HiveField(5)
  int id;

  MostPlayed(
      {required this.songname,
      required this.songurl,
      required this.duration,
      required this.artist,
      required this.count,
      required this.id});
}
