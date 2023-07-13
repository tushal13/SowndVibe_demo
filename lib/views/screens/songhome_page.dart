import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sowndvibe/utility/music_list.dart';
import '../../controllers/songs_controller.dart';

class SongHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Best of artists",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: allSongs.length,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  mainAxisExtent: 280,
                  childAspectRatio: 2 / 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Provider.of<SongPlayerController>(context, listen: false)
                          .ChangeSongIndex(index: index);
                      Navigator.of(context).pushNamed(
                        'SongPlayer',
                        arguments: index,
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Container(
                            width: 180,
                            height: 180,
                            child: Card(
                              elevation: 4,
                              child: Image.network(
                                allSongs[index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            allSongs[index].name,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            allSongs[index].singer,
                            style: TextStyle(color: Colors.white54),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
