import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:typed_data';

class MarqueeDisplay extends StatelessWidget {
  final List<AssetEntity> photos;

  const MarqueeDisplay({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      child: photos.isEmpty
          ? const Center(
        child: Text(
          "No old photos found",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      )
          : SingleChildScrollView(
        scrollDirection: Axis.vertical, //vertical
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 8), //vertical
        child: Column(
          children: photos.map((photo) {
            return FutureBuilder<Uint8List?>(
              future: photo.thumbnailDataWithSize(
                const ThumbnailSize(300 ,300),
              ), // Fetch optimized thumbnail size
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    width: 300,
                    height: 300,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        snapshot.data!,
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox(
                    width: 300,
                    height: 300,
                    child: Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}