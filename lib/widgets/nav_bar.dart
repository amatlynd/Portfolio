import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onHeroTap;
  final VoidCallback onAboutTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  const NavBar({
    super.key,
    required this.onHeroTap,
    required this.onAboutTap,
    required this.onProjectsTap,
    required this.onContactTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;

    return AppBar(
      leading: const SizedBox.shrink(),
      leadingWidth: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            GestureDetector(
              onTap: onHeroTap,
              child: Text(
                'Lyndon Amat',
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
            ),
            const Spacer(),
            if (isWide) ...[
              _NavLink(label: 'About', onTap: onAboutTap),
              const SizedBox(width: 32),
              _NavLink(label: 'Projects', onTap: onProjectsTap),
              const SizedBox(width: 32),
              _NavLink(label: 'Contact', onTap: onContactTap),
              const SizedBox(width: 8),
            ] else
              IconButton(
                icon: const Icon(Icons.menu, color: AppTheme.textPrimary),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => _MobileMenu(
                      onAboutTap: onAboutTap,
                      onProjectsTap: onProjectsTap,
                      onContactTap: onContactTap,
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final VoidCallback onAboutTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  const _MobileMenu({
    required this.onAboutTap,
    required this.onProjectsTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              onAboutTap();
            },
          ),
          ListTile(
            title: const Text('Projects'),
            onTap: () {
              Navigator.pop(context);
              onProjectsTap();
            },
          ),
          ListTile(
            title: const Text('Contact'),
            onTap: () {
              Navigator.pop(context);
              onContactTap();
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
