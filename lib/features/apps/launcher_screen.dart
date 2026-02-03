import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:installed_apps/installed_apps.dart';
import 'launcher_provider.dart';

class LauncherScreen extends ConsumerWidget {
  const LauncherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appsAsync = ref.watch(appsProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('All Apps'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: appsAsync.when(
        data: (apps) => GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 20,
            crossAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: apps.length,
          itemBuilder: (context, index) {
            final app = apps[index];

            return GestureDetector(
              onTap: () => InstalledApps.startApp(app.packageName),
              child: Column(
                children: [
                  if (app.icon != null)
                    Image.memory(app.icon!, width: 50, height: 50)
                  else
                    const Icon(Icons.android, size: 50, color: Colors.green),
                  const SizedBox(height: 8),
                  Text(
                    app.name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text('Error: $err', style: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }
}
