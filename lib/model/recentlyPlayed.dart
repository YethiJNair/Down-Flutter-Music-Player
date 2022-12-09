import 'package:hive/hive.dart';
part 'recentlyPlayed.g.dart';

@HiveType(typeId: 4)
class RecentlyPlayed {
  @HiveField(0)
  String? songname;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  String? songurl;
  @HiveField(4)
  int? id;
  RecentlyPlayed(
      {this.songname,
      this.artist,
      this.duration,
      this.songurl,
      required this.id});
}
