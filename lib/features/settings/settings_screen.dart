import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:launcher_gf101/features/settings/wallpaper_provider.dart';
import 'package:launcher_gf101/theme/theme_provider.dart';
import '../../core/widgets/background_mesh.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          const BackgroundMesh(),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    children: [
                      _buildSectionHeader('Appearance'),
                      _SettingItem(
                        icon: Icons.palette,
                        title: 'Theme',
                        subtitle: 'Toggle between light and dark mode',
                        onTap: () {
                          ref.read(themeProvider.notifier).toggleTheme();
                        },
                      ),
                      const SizedBox(height: 12),
                      _SettingItem(
                        icon: Icons.image,
                        title: 'Set Wallpaper',
                        subtitle: 'Choose a background from your gallery',
                        onTap: () {
                          ref.read(wallpaperProvider.notifier).setWallpaper();
                        },
                      ),
                      const SizedBox(height: 12),
                      _SettingItem(
                        icon: Icons.image_not_supported,
                        title: 'Clear Wallpaper',
                        subtitle: 'Remove the custom wallpaper',
                        onTap: () {
                          ref.read(wallpaperProvider.notifier).clearWallpaper();
                        },
                      ),
                      const SizedBox(height: 12),
                      _SettingItem(
                        icon: Icons.grid_view,
                        title: 'Icon Pack',
                        subtitle: 'Minimalist, adaptive icons',
                        onTap: () {},
                      ),
                      const SizedBox(height: 24),
                      _buildSectionHeader('Interaction'),
                      _SettingItem(
                        icon: Icons.swipe,
                        title: 'Gestures',
                        subtitle: 'Swipe actions, double tap',
                        onTap: () {},
                      ),
                      const SizedBox(height: 24),
                      _buildSectionHeader('Productivity'),
                      _SettingItem(
                        icon: Icons.filter_center_focus,
                        title: 'Focus Mode Settings',
                        subtitle: 'App blocking, scheduling',
                        onTap: () {},
                      ),
                      const SizedBox(height: 24),
                      _buildSectionHeader('System'),
                      _SettingItem(
                        icon: Icons.info_outline,
                        title: 'About Launcher',
                        subtitle: 'Version 2.4.1 (Stable)',
                        iconColor: Colors.white.withOpacity(0.6),
                        iconBgColor: Colors.white.withOpacity(0.05),
                        onTap: () {},
                      ),
                      const SizedBox(height: 100), // Space for absolute footer
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildFooter()),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 48, bottom: 32),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'Launcher Settings',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 16),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.inter(
          color: Colors.white.withOpacity(0.4),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 64,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF101622).withOpacity(0),
                const Color(0xFF101622),
              ],
            ),
          ),
        ),
        Container(
          color: const Color(0xFF101622),
          padding: const EdgeInsets.only(bottom: 24),
          child: Center(
            child: Container(
              width: 128,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? iconBgColor;

  const _SettingItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.iconColor,
    this.iconBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: iconBgColor ?? const Color(0xFF135BEC).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor ?? const Color(0xFF135BEC),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.2)),
          ],
        ),
      ),
    );
  }
}
