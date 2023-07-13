import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chewie/chewie.dart';
import '../../controllers/video_controller.dart';

class VideoHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<VideoPlayerC>(
        builder: (context, videoPlayerProvider, _) {
          final chewieController = videoPlayerProvider.chewieController;
          final videoPlayerController =
              videoPlayerProvider.videoPlayerController;

          if (videoPlayerController != null && chewieController != null) {
            return Column(
              children: [
                AspectRatio(
                  aspectRatio: videoPlayerController.value.aspectRatio,
                  child: Chewie(controller: chewieController),
                ),
              ],
            );
          } else {
            return Center(
              child: Text(
                'Select a video from the gallery',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final videoPlayerProvider =
              Provider.of<VideoPlayerC>(context, listen: false);
          videoPlayerProvider.pickVideoFromDevice();
        },
        child: Icon(Icons.video_collection),
      ),
    );
  }
}
