import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final wallpaperProvider = StateNotifierProvider<WallpaperNotifier, File?>((
  ref,
) {
  return WallpaperNotifier();
});

class WallpaperNotifier extends StateNotifier<File?> {
  WallpaperNotifier() : super(null) {
    _loadWallpaper();
  }

  final String _wallpaperKey = 'wallpaperPath';

  void _loadWallpaper() async {
    final prefs = await SharedPreferences.getInstance();
    final wallpaperPath = prefs.getString(_wallpaperKey);
    if (wallpaperPath != null) {
      state = File(wallpaperPath);
    }
  }

  Future<void> setWallpaper() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      state = File(pickedFile.path);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_wallpaperKey, pickedFile.path);
    }
  }

  void clearWallpaper() async {
    state = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_wallpaperKey);
  }
}
