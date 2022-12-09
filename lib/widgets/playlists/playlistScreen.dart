// ignore_for_file: camel_case_types, prefer_final_fields, non_constant_identifier_names, unused_local_variable

import 'package:down/colors/colors.dart';
import 'package:down/model/dbfunctions.dart';
import 'package:down/model/playlistmodel.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:down/widgets/playlists/screenPlaylist.dart';

class playLists extends StatefulWidget {
  const playLists({super.key});

  @override
  State<playLists> createState() => _playListsState();
}

class _playListsState extends State<playLists> {
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController controller = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  final formGlobalKey1 = GlobalKey<FormState>();

  List<PlaylistSongs> playlist = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            HexColor("#0f1223"),
            HexColor("#070915"),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black.withOpacity(0),
          elevation: 0,
          title: Container(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Text(
                  "P",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: cyan),
                ),
                Text(
                  "laylilst",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: white),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => bottomSheet(context),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 40,
                  )),
            )
          ],
        ),
        backgroundColor: black.withOpacity(0),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [PlaylistList()],
            ),
          ),
        ),
      ),
    );
  }

  //----------------------------------------LIST OF PLAYLISTS--------------------------------------------------
  PlaylistList() {
    if (playlist.isEmpty) {
      const Padding(
        padding: EdgeInsets.all(15.0),
        child: Align(
          heightFactor: 7.5,
          child: Center(
              child: Text(
            'No Playlist Created',
            style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w500),
          )),
        ),
      );
    }
    return ValueListenableBuilder<Box<PlaylistSongs>>(
        valueListenable: playlistbox.listenable(),
        builder: (context, value, child) {
          List<PlaylistSongs> playlist = value.values.toList();

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: playlist.length,
              itemBuilder: ((context, index) {
                if (playlistbox.isEmpty) {
                  final controller = playlist[index].playlistname!;
                  Center(
                    child: Text(
                      "Playlist Not Created",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  );
                }
                if (playlist.isEmpty) {
                  Center(
                    child: Text(
                      "Playlist Not Created",
                      style: TextStyle(
                          fontSize: 13.43,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  );
                }
                return ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ScreenPlaylist(
                              allPlaylistSongs: playlist[index].playlistssongs!,
                              playlistindex: index,
                              playlistname: playlist[index].playlistname!)))),
                  leading: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.asset(
                      'assets/images/music.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  // leading: Icon(
                  //   Icons.queue_music_rounded,
                  //   color: Colors.white,
                  //   size: 35,
                  // ),
                  title: Text(
                    playlist[index].playlistname.toString(),
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  bottomSheetedit(context, index),
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.grey,
                          )),
                      IconButton(
                        onPressed: (() {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                                title: Text(
                                  "Delete Playlist",
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: Text(
                                  "Are You Sure ?",
                                  style: TextStyle(color: Colors.white),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancel",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 213, 213, 213)))),
                                  TextButton(
                                      onPressed: () {
                                        playlistbox.deleteAt(index);
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Delete",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 213, 213, 213))))
                                ],
                              );
                            },
                          );
                        }),
                        icon: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 132, 25, 25),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          );
        });
  }

  //----------------------------------------ADD PLAYLIST POP UP--------------------------------------------------

  Widget bottomSheet(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 423 * 0.7,
          color: Colors.black,
          child: Column(
            children: [playlistform(context)],
          ),
        ),
      ),
    );
  }

  Widget bottomSheetedit(BuildContext context, int index) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 423 * 0.7,
          color: const Color.fromARGB(255, 24, 24, 24),
          child: Column(
            children: [editBottom(context, index)],
          ),
        ),
      ),
    );
  }

  Padding playlistform(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "C",
                style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: cyan),
              ),
              Text(
                "reate Playlist",
                style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Form(
            key: formGlobalKey,
            child: TextFormField(
              controller: _textEditingController,
              cursorHeight: 25,
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
                hintStyle: TextStyle(color: Color.fromARGB(255, 137, 137, 137)),
              ),
              validator: (value) {
                List<PlaylistSongs> values = playlistbox.values.toList();

                bool isAlreadyAdded = values
                    .where((element) => element.playlistname == value!.trim())
                    .isNotEmpty;

                if (value!.trim() == '') {
                  return 'Name required';
                }
                if (value.trim().length > 10) {
                  return 'Enter Characters below 10 ';
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
    );
  }

  Row formButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            child: const Text("Cancel")),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: cyan),
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

  Widget editBottom(BuildContext context, int index) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "E",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: cyan),
                ),
                Text(
                  "dit Playlist",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: formGlobalKey1,
              child: TextFormField(
                controller: controller,
                cursorHeight: 25,
                decoration: const InputDecoration(
                  filled: true,
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.5)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.5)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.5)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.5)),
                  hintText: "Enter a name",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                validator: (value) {
                  List<PlaylistSongs> values = playlistbox.values.toList();

                  bool isAlreadyAdded = values
                      .where((element) => element.playlistname == value!.trim())
                      .isNotEmpty;

                  if (value!.trim() == '') {
                    return 'Name Required';
                  }
                  if (value.trim().length > 10) {
                    return 'Enter Characters below 10 ';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            formButtonsedit(context, index)
          ],
        ),
      ),
    );
  }

  Row formButtonsedit(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("cancel")),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: cyan),
            onPressed: () {
              final isValid = formGlobalKey1.currentState!.validate();
              if (isValid) {
                playlistbox.putAt(
                    index,
                    PlaylistSongs(
                        playlistname: controller.text, playlistssongs: []));
                Navigator.pop(context);
              }
            },
            child: const Text("Edit"))
      ],
    );
  }
}
