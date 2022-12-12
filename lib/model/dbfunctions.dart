import 'package:hive/hive.dart';
import 'package:down/model/favouriteModel.dart';
import 'package:down/model/mostPlayed.dart';
import 'package:down/model/playlistmodel.dart';
import 'package:down/model/recentlyPlayed.dart';
import 'package:down/screens/most_played.dart';

late Box<favsongs> favsongsdb;
opendb_fav() async {
  favsongsdb = await Hive.openBox<favsongs>('favsongs');
}

late Box<PlaylistSongs> playlistbox;
opendatabase() async {
  playlistbox = await Hive.openBox<PlaylistSongs>('playlist');
}

late Box<RecentlyPlayed> recentlyplayedbox;
openrecentlyplayeddb() async {
  recentlyplayedbox = await Hive.openBox("recentlyplayed");
}

updateRecentPlayed(RecentlyPlayed value, index) {
  List<RecentlyPlayed> list = recentlyplayedbox.values.toList();
  bool isAlready =
      list.where((element) => element.songname == value.songname).isEmpty;
  if (isAlready == true) {
    recentlyplayedbox.add(value);
  } else {
    int index =
        list.indexWhere((element) => element.songname == value.songname);
    recentlyplayedbox.deleteAt(index);
    recentlyplayedbox.add(value);
  }
}

late Box<MostPlayed> mostplayedsongs;
openmostplayeddb() async {
  mostplayedsongs = await Hive.openBox("mostplayed");
}

updatePlayedSongsCount(MostPlayed value, int index) {
  List<MostPlayed> list1 = mostplayedsongs.values.toList();
  bool isAlready =
      list1.where((element) => element.songname == value.songname).isEmpty;
  if (isAlready == true) {
    mostplayedsongs.add(value);
  } else {
    int index =
        list1.indexWhere((element) => element.songname == value.songname);
    mostplayedsongs.deleteAt(index);
    // mostplayedsongs.add(value);
    mostplayedsongs.put(index, value);
  }
  int count = value.count;
  value.count = count + 1;
}
