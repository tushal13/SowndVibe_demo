import 'package:flutter/material.dart';
import 'package:sowndvibe/views/screens/home_page.dart';
import 'package:sowndvibe/views/screens/video_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, value) => [
          SliverAppBar(
            title: const Text("Sowndvibe"),
            pinned: true,

            bottom: TabBar(
              controller: tabController,
              tabs: const [
                Tab(
                  text: "Songs",
                ),
                Tab(
                  text: "Videos",
                ),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: tabController,
          children: [
            // SongPage(),
            SongHomePage(),
            VideoHomePage(),
          ],
        ),
      ),
    );
  }
}
