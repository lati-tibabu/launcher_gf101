import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appsProvider = FutureProvider<List<AppInfo>>((ref) async {
  List<AppInfo> apps = await InstalledApps.getInstalledApps(
    withIcon: true,
    excludeSystemApps: false,
    excludeNonLaunchableApps: true,
  );
  
  // Sort apps alphabetically by name
  apps.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  
  return apps;
});
