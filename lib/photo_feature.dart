import 'package:flutter/material.dart';
import 'photo_manager.dart';
import 'package:photo_manager/photo_manager.dart';
import 'marquee.dart';

class PhotoFeatureApp extends StatefulWidget {
  const PhotoFeatureApp({super.key});

  @override
  PhotoFeatureAppState createState() => PhotoFeatureAppState();
}

class PhotoFeatureAppState extends State<PhotoFeatureApp> {
  List<AssetEntity> oldPhotos = [];
  @override
  void initState() {
    super.initState();
    loadPhotos();
  }

  Future<void> loadPhotos() async {
    if (await PhotoManagerService.requestPermission()) {
      List<AssetEntity> photos = await PhotoManagerService.fetchAndSelectRandomOldPhotos();
      setState(() {
        oldPhotos = photos;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Photo Highlights")),
        body: Center(child: MarqueeDisplay(photos: oldPhotos)),
      ),
    );
  }
}
