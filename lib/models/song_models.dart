import 'package:flutter/material.dart';

class Song {
  final String name;
  final String singer;
  final String audio;
  final String image;
  final int duration;
  final Color color;

  Song({
    required this.name,
    required this.singer,
    required this.audio,
    required this.image,
    required this.duration,
    required this.color,
  });
}
