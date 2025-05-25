import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

class VoiceAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
    glowColor: Colors.blue,
    duration: Duration(milliseconds: 2000),
    repeat: true,
    child: Material(
      elevation: 8.0,
      shape: CircleBorder(),
      child: CircleAvatar(
        backgroundColor: Colors.blue,
        radius: 40.0, // Use radius instead
        child: Icon(Icons.mic, color: Colors.white, size: 30.0),
      ),
    ),
  );
  }
}