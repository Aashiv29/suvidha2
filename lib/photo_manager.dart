import 'dart:math';
import 'package:photo_manager/photo_manager.dart';

class PhotoManagerService {
  // Request gallery access permission
  static Future<bool> requestPermission() async {
    PermissionState result = await PhotoManager.requestPermissionExtend();
    return result.isAuth;
  }

  // Fetch photos between 2 months and 2 years old, and randomly select 10
  static Future<List<AssetEntity>> fetchAndSelectRandomOldPhotos() async {
    DateTime now = DateTime.now();
    DateTime twoMonthsAgo = now.subtract(Duration(days: 60));
    DateTime twoYearsAgo = now.subtract(Duration(days: 730));

    // Get all albums
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(type: RequestType.image);

    List<AssetEntity> oldPhotos = [];

    for (var album in albums) {
      List<AssetEntity> assets = await album.getAssetListPaged(page: 0, size: 100);

      for (var asset in assets) {
        if (asset.createDateTime.isAfter(twoYearsAgo) && asset.createDateTime.isBefore(twoMonthsAgo)) {
          oldPhotos.add(asset);
        }
      }
    }

    // Randomly select 10 photos
    return _selectRandomPhotos(oldPhotos, 10);
  }

  // Helper function to randomly select a specified number of photos
  static List<AssetEntity> _selectRandomPhotos(List<AssetEntity> photos, int count) {
    if (photos.isEmpty) {
      return [];
    }

    final random = Random();
    List<AssetEntity> selectedPhotos = [];
    List<int> indices = [];

    // Ensure we don't select more photos than available
    int selectionCount = count > photos.length ? photos.length : count;

    while (selectedPhotos.length < selectionCount) {
      int randomIndex = random.nextInt(photos.length);
      if (!indices.contains(randomIndex)) {
        indices.add(randomIndex);
        selectedPhotos.add(photos[randomIndex]);
      }
    }

    return selectedPhotos;
  }
}