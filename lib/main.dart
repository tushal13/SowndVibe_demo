import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sowndvibe/controllers/songs_controller.dart';
import 'package:sowndvibe/views/screens/home.dart';
import 'package:sowndvibe/views/screens/songplayer_page.dart';
import 'controllers/video_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SongPlayerController(),
        ),
        ChangeNotifierProvider(
          create: (context) => VideoPlayerC(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        brightness: Brightness.dark,
      ),
      title: 'SowndVibe',
      routes: {
        '/': (context) => HomePage(),
        'SongPlayer': (context) => SongPlayerPage(),
      },
    );
  }
}
