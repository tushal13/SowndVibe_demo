import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:sowndvibe/utility/music_list.dart';

class SongPlayerController extends ChangeNotifier {
  AssetsAudioPlayer AudioPlayer = AssetsAudioPlayer();
  Duration TotalDuration = Duration.zero;
  int CurrentSongIndex = 0;
  PaletteGenerator? _paletteGenerator;
  Color? dominantColor;
  bool _isShuffleOn = false;
  bool _isLoopOn = false;

  bool get isShuffleOn => _isShuffleOn;
  bool get isLoopOn => _isLoopOn;

  setupPlaylist({int index = 0}) async {
    await AudioPlayer.open(
      Audio(
        allSongs[index].audio,
        metas: Metas(
          title: allSongs[index].name,
          artist: allSongs[index].singer,
          image: MetasImage.network(
            allSongs[index].image,
          ),
        ),
      ),
      autoStart: false,
      showNotification: true,
    ).then((value) {
      TotalDuration = AudioPlayer.current.value!.audio.duration;
    });
  }

  updateDominantColor(String imageUrl) async {
    final imageProvider = NetworkImage(imageUrl);
    _paletteGenerator = await PaletteGenerator.fromImageProvider(
      imageProvider,
      maximumColorCount: 20,
    );
    if (_paletteGenerator != null) {
      dominantColor = _paletteGenerator!.dominantColor?.color;
      notifyListeners();
    }
  }

  ChangeSongIndex({required int index}) {
    AudioPlayer.pause();
    setupPlaylist(index: index);
    CurrentSongIndex = index;
    notifyListeners();
  }

  play() async {
    await AudioPlayer.play();
    notifyListeners();
  }

  pause() async {
    await AudioPlayer.pause();
    notifyListeners();
  }

  onSeek({required int sec}) async {
    await AudioPlayer.seek(Duration(seconds: sec));
  }

  Previous() async {
    if (CurrentSongIndex > 0) {
      await AudioPlayer.previous();
    }
    notifyListeners();
  }

  Next() async {
    if (CurrentSongIndex < allSongs.length) {
      await AudioPlayer.next();
    }
    notifyListeners();
  }

  toggleShuffle() {
    _isShuffleOn = !_isShuffleOn;
    AudioPlayer.toggleShuffle();
    notifyListeners();
  }

  toggleLoop() {
    _isLoopOn = !_isLoopOn;
    AudioPlayer.toggleLoop();
    notifyListeners();
  }

  get isPlaying {
    return AudioPlayer.isPlaying.value;
  }

  get currentPosition {
    return AudioPlayer.currentPosition;
  }
}
