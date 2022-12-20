// ignore: file_names
// ignore_for_file: must_be_immutable, file_names, duplicate_ignore, prefer_final_fields
import 'package:down/colors/colors.dart';
import 'package:down/model/dbfunctions.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../../model/playlistmodel.dart';
import '../../model/songModel.dart';

class addToPlaylist extends StatefulWidget {
  int songindex;
  addToPlaylist({super.key, required this.songindex});

  @override
  State<addToPlaylist> createState() => _PlayScreenPlstState();
}

class _PlayScreenPlstState extends State<addToPlaylist> {
  TextEditingController _textEditingController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          await playlistBottomSheet(context);

          //Navigator.pop(context);
        },
        icon: const Icon(
          Icons.playlist_add,
          color: Colors.grey,
        ));
  }

  Future<dynamic> playlistBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (context, setState) => Container(
                  height: 200,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  child: ValueListenableBuilder(
                    valueListenable: playlistbox.listenable(),
                    builder: (context, Box<PlaylistSongs> playlistbox, _) {
                      List<PlaylistSongs> playlist =
                          playlistbox.values.toList();

                      if (playlistbox.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      "Create a playlist.",
                                      style: TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 35,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: buttonColor),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) =>
                                            bottomSheet(context),
                                      );
                                    },
                                    child: const Text("Create Playlist"))
                              ],
                            ),
                          ),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "Your Playlists.",
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 35,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Expanded(
                                child: ListView.builder(
                                    itemCount: playlist.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: SizedBox(
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            child: Container(
                                              height: 40,
                                              child: Image.asset(
                                                'assets/images/music.jpg',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          playlist[index]
                                              .playlistname
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        onTap: () {
                                          PlaylistSongs? plsongs =
                                              playlistbox.getAt(index);
                                          List<Songs>? plnewsongs =
                                              plsongs!.playlistssongs;
                                          Box<Songs> box = Hive.box('Songs');
                                          List<Songs> dbAllsongs =
                                              box.values.toList();
                                          bool isAlreadyAdded = plnewsongs!.any(
                                              (element) =>
                                                  element.id ==
                                                  dbAllsongs[widget.songindex]
                                                      .id);

                                          if (!isAlreadyAdded) {
                                            plnewsongs.add(Songs(
                                              songname:
                                                  dbAllsongs[widget.songindex]
                                                      .songname,
                                              artist:
                                                  dbAllsongs[widget.songindex]
                                                      .artist,
                                              duration:
                                                  dbAllsongs[widget.songindex]
                                                      .duration,
                                              songurl:
                                                  dbAllsongs[widget.songindex]
                                                      .songurl,
                                              id: dbAllsongs[widget.songindex]
                                                  .id,
                                            ));

                                            playlistbox.putAt(
                                                index,
                                                PlaylistSongs(
                                                    playlistname:
                                                        playlist[index]
                                                            .playlistname,
                                                    playlistssongs:
                                                        plnewsongs));

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        Colors.black,
                                                    content: Text(
                                                        '${dbAllsongs[widget.songindex].songname}Added to ${playlist[index].playlistname}')));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        Colors.black,
                                                    content: Text(
                                                        '${dbAllsongs[widget.songindex].songname} is already added')));
                                          }
                                          Navigator.pop(context);
                                        },
                                      );
                                    }))
                          ],
                        ),
                      );
                    },
                  ),
                ));
      },
    );
  }

  //----------------------------------------Function to Create Playlist--------------------------------------------------
  Widget bottomSheet(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 250,
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [playlistform(context)],
        ),
      ),
    );
  }

  Padding playlistform(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  "C",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey),
                ),
                Text(
                  "reate playlist.",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: formGlobalKey,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.5)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.5)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.5)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.5)),
                  hintText: "Enter a name",
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 137, 137, 137)),
                ),
                controller: _textEditingController,
                cursorHeight: 25,
                validator: (value) {
                  List<PlaylistSongs> values = playlistbox.values.toList();

                  bool isAlreadyAdded = values
                      .where((element) => element.playlistname == value!.trim())
                      .isNotEmpty;

                  if (value!.trim() == '') {
                    return 'Name required';
                  }
                  if (value.trim().length > 15) {
                    return 'Enter Characters below 15 ';
                  }

                  if (isAlreadyAdded) {
                    return 'Name Already Exists';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            formButtons(context)
          ],
        ),
      ),
    );
  }

  Row formButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
            onPressed: () {
              final isValid = formGlobalKey.currentState!.validate();
              if (isValid) {
                playlistbox.add(PlaylistSongs(
                    playlistname: _textEditingController.text,
                    playlistssongs: []));
                Navigator.pop(context);
              }
            },
            child: const Text("Create"))
      ],
    );
  }
}
