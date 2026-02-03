import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../apps/launcher_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101622),
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! < -500) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LauncherScreen()),
            );
          }
        },
        child: Stack(
          children: [
            // Background Gradient Mesh
            const _BackgroundMesh(),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    // Top Bar
                    const _TopBar(),

                    const SizedBox(height: 48),

                    // Clock and Date
                    const _ClockSection(),

                    const SizedBox(height: 32),

                    // Search Bar
                    const _SearchBarSection(),

                    const Spacer(),

                    // Favorites Dock
                    const _FavoritesDock(),

                    const SizedBox(height: 32),

                    // Bottom Gesture Indicator
                    const _GestureIndicator(),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundMesh extends StatelessWidget {
  const _BackgroundMesh();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF101622)),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.0,
                  colors: [Color(0xFF1A243A), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.bottomRight,
                  radius: 1.0,
                  colors: [Color(0xFF0D121C), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.2,
                  colors: [Color(0x22135BEC), Colors.transparent],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.filter_center_focus,
                  color: Color(0xFF135BEC),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Focus Mode',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ClockSection extends StatelessWidget {
  const _ClockSection();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        final now = DateTime.now();
        final timeFormatter = DateFormat('HH:mm');
        final dateFormatter = DateFormat('EEEE, MMMM dd');

        return Column(
          children: [
            Text(
              timeFormatter.format(now),
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 84,
                fontWeight: FontWeight.bold,
                letterSpacing: -2,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              dateFormatter.format(now),
              style: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.6),
                fontSize: 20,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SearchBarSection extends StatelessWidget {
  const _SearchBarSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ColorFilter.mode(
            Colors.white.withOpacity(0.05),
            BlendMode.srcOver,
          ),
          child: TextField(
            style: GoogleFonts.inter(color: Colors.white, fontSize: 18),
            decoration: InputDecoration(
              hintText: 'Search apps or web',
              hintStyle: GoogleFonts.inter(color: const Color(0xFF92A4C9)),
              prefixIcon: const Icon(Icons.search, color: Color(0xFF92A4C9)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ),
    );
  }
}

class _FavoritesDock extends StatelessWidget {
  const _FavoritesDock();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _DockItem(
            icon: Icons.call,
            label: 'Phone',
            isPrimary: true,
            onTap: () => launchUrl(Uri.parse('tel:')),
          ),
          _DockItem(
            icon: Icons.chat_bubble,
            label: 'Chat',
            onTap: () => launchUrl(Uri.parse('sms:')),
          ),
          _DockItem(
            icon: Icons.language,
            label: 'Web',
            onTap: () => launchUrl(Uri.parse('https://www.google.com')),
          ),
          _DockItem(
            icon: Icons.photo_camera,
            label: 'Camera',
            onTap: () {}, // Camera usually needs specific intents or package
          ),
        ],
      ),
    );
  }
}

class _DockItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const _DockItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  State<_DockItem> createState() => _DockItemState();
}

class _DockItemState extends State<_DockItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: _isHovered
                    ? const Color(0xFF135BEC)
                    : (widget.isPrimary
                          ? const Color(0xFF135BEC).withOpacity(0.2)
                          : Colors.white.withOpacity(0.05)),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _isHovered
                      ? const Color(0xFF135BEC)
                      : (widget.isPrimary
                            ? const Color(0xFF135BEC).withOpacity(0.3)
                            : Colors.white.withOpacity(0.1)),
                ),
              ),
              child: Icon(
                widget.icon,
                size: 32,
                color: _isHovered
                    ? Colors.white
                    : (widget.isPrimary
                          ? const Color(0xFF135BEC)
                          : Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.label,
              style: GoogleFonts.inter(
                color: _isHovered
                    ? Colors.white
                    : Colors.white.withOpacity(0.5),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GestureIndicator extends StatelessWidget {
  const _GestureIndicator();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 128,
        height: 6,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}
