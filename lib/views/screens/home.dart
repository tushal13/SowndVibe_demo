import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sowndvibe/views/screens/video_home.dart';

import '../../controllers/homepage_controller.dart';
import 'songhome_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sowndvibe"),
      ),
      body: Consumer<HomePageController>(
        builder: (context, model, child) {
          if (model.currentIndex == 0) {
            return SongHomePage();
          } else if (model.currentIndex == 1) {
            return VideoHomePage();
          } else {
            return Container(); // Replace with desired default widget
          }
        },
      ),
      bottomNavigationBar: Consumer<HomePageController>(
        builder: (context, model, child) {
          return BottomNavigationBar(
            currentIndex: model.currentIndex,
            onTap: (index) {
              model.setCurrentIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.music_note),
                label: "Songs",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.video_library),
                label: "Videos",
              ),
            ],
          );
        },
      ),
    );
  }
}
