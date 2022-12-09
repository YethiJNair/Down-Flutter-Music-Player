import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:down/model/dbfunctions.dart';
import 'package:down/model/favouriteModel.dart';
import 'package:down/model/playlistmodel.dart';
import 'package:down/model/songModel.dart';
import 'package:down/screens/SplashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<Songs>(boxname);

  Hive.registerAdapter(favsongsAdapter());
  opendb_fav();

  runApp(MyApp());
  Hive.registerAdapter(PlaylistSongsAdapter());
  opendatabase();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: "Musify",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Splash(),
    );
  }
}
