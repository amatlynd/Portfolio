import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/hover_scale.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewWork;

  const HeroSection({super.key, required this.onViewWork});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 700;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: size.height * 0.88),
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: 80,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AccentTag(),
          const SizedBox(height: 24),
          Text(
            "Hi, I'm\nLyndon Amat.",
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: isWide ? 72 : 48,
                ),
          ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              'Software developer focused on building clean, user-friendly products — '
              'from mobile apps to web experiences.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              HoverScale(
                child: ElevatedButton(
                  onPressed: onViewWork,
                  child: const Text('View My Work'),
                ),
              ),
              const SizedBox(width: 16),
              HoverScale(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Get In Touch'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AccentTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: AppTheme.accent,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          'Available for work',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.accent,
          ),
        ),
      ],
    );
  }
}
