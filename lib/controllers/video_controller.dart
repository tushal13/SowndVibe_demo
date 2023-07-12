import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerC with ChangeNotifier {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isLocalVideo = false;

  VideoPlayerController? get videoPlayerController => _videoPlayerController;
  ChewieController? get chewieController => _chewieController;
  bool get isLocalVideo => _isLocalVideo;

  VideoPlayerProvider() {
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    await _videoPlayerController!.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: false,
      looping: true,
    );

    notifyListeners();
  }

  Future<void> pickVideoFromDevice() async {
    XFile? videoFile =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (videoFile != null) {
      _videoPlayerController?.dispose();
      _chewieController?.dispose();

      File file = File(videoFile.path);
      _videoPlayerController = VideoPlayerController.file(file);
      await _videoPlayerController!.initialize();
      _isLocalVideo = true;

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: false,
        looping: true,
      );

      notifyListeners();
    }
  }
}
