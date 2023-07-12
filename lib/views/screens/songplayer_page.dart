import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sowndvibe/controllers/songs_controller.dart';
import 'package:sowndvibe/utility/music_list.dart';

class SongPlayerPage extends StatelessWidget {
  const SongPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SongPlayer = Provider.of<SongPlayerController>(context);

    return Consumer<SongPlayerController>(builder: (context, provider, _) {
      final song = allSongs[provider.CurrentSongIndex];

      return Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    provider.dominantColor ?? Colors.black,
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Center(
              child: ListView(
                children: [
                  StreamBuilder(
                      stream: provider.AudioPlayer.currentPosition,
                      builder: (context, AsyncSnapshot<Duration> snapshot) {
                        final String imageUrl = song.image;
                        SongPlayer.updateDominantColor(imageUrl);
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "PLAYING FROM ${song.singer}",
                                        style: TextStyle(
                                          letterSpacing: 2,
                                          color:
                                              Colors.grey.shade300.withOpacity(
                                            0.6,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "${song}",
                                        style: TextStyle(
                                            letterSpacing: 3,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 35,
                              ),
                              height: 350,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(song.image),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          song.name!.toUpperCase() ?? '',
                                          style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: 2,
                                              fontSize: 18),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "${song.singer!.toUpperCase()}" ?? '',
                                        style: TextStyle(
                                          color: Colors.grey.shade300
                                              .withOpacity(0.8),
                                          letterSpacing: 2,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 26),
                            SliderTheme(
                              data: SliderThemeData(
                                  trackHeight: 2,
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 6,
                                      disabledThumbRadius: 6)),
                              child: Slider(
                                value: snapshot.data!.inSeconds.toDouble(),
                                min: 0.0,
                                max: SongPlayer.TotalDuration.inSeconds
                                    .toDouble(),
                                activeColor: Colors.white,
                                inactiveColor:
                                    Colors.grey.shade300.withOpacity(0.4),
                                thumbColor: Colors.white,
                                onChanged: (value) {
                                  provider.onSeek(sec: value.toInt());
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, right: 18),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${snapshot.data!.inMinutes.toString().padLeft(2, '0')}:${(snapshot.data!.inSeconds % 60).toString().padLeft(2, '0')}"),
                                  Text(
                                      "${provider.TotalDuration.inMinutes.toString().padLeft(2, '0')}:${(provider.TotalDuration.inSeconds % 60).toString().padLeft(2, '0')}")
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Row(
                                    children: [
                                      Consumer<SongPlayerController>(
                                        builder:
                                            (context, audioPlayerProvider, _) {
                                          final isShuffleOn =
                                              audioPlayerProvider.isShuffleOn;

                                          return IconButton(
                                            onPressed: () {
                                              audioPlayerProvider
                                                  .toggleShuffle();
                                            },
                                            icon: Icon(
                                              CupertinoIcons.shuffle,
                                              color: isShuffleOn
                                                  ? Colors.green
                                                  : Colors.white,
                                              size: 24,
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          provider.ChangeSongIndex(
                                              index: provider.CurrentSongIndex -
                                                  1);
                                          SongPlayer.Previous();
                                        },
                                        iconSize: 48,
                                        icon: Icon(
                                          Icons.skip_previous,
                                          color: Colors.white,
                                          size: 44,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    StreamBuilder(
                                      stream: provider.AudioPlayer.isPlaying,
                                      builder: (context, snapshot) {
                                        return IconButton(
                                          onPressed: () {
                                            if (snapshot.data!) {
                                              provider.pause();
                                            } else {
                                              provider.play();
                                            }
                                          },
                                          iconSize: 48,
                                          icon: Icon(
                                            snapshot.data!
                                                ? Icons.pause_circle_sharp
                                                : Icons.play_circle_fill_sharp,
                                            color: Colors.white,
                                            size: 74,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          provider.ChangeSongIndex(
                                              index: provider.CurrentSongIndex +
                                                  1);
                                          SongPlayer.Next();
                                        },
                                        iconSize: 48,
                                        icon: Icon(
                                          Icons.skip_next,
                                          color: Colors.white,
                                          size: 44,
                                        ),
                                      ),
                                      Consumer<SongPlayerController>(
                                        builder:
                                            (context, audioPlayerProvider, _) {
                                          final isLoopOn =
                                              audioPlayerProvider.isLoopOn;

                                          return IconButton(
                                            onPressed: () {
                                              audioPlayerProvider.toggleLoop();
                                            },
                                            icon: Icon(
                                              CupertinoIcons.repeat,
                                              color: isLoopOn
                                                  ? Colors.green
                                                  : Colors.white,
                                              size: 24,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      }),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
