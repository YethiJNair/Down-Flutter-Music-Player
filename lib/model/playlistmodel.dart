import 'package:hive/hive.dart';
import 'package:down/model/songModel.dart';
part 'playlistmodel.g.dart';

@HiveType(typeId: 2)
class PlaylistSongs {
  @HiveField(0)
  String? playlistname;
  @HiveField(1)
  List<Songs>? playlistssongs;
  PlaylistSongs({required this.playlistname, required this.playlistssongs});
}
