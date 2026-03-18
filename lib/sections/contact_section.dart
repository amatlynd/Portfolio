import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/hover_scale.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;

    return Container(
      width: double.infinity,
      color: AppTheme.surface,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Get In Touch', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Text(
              "I'm always open to new opportunities and interesting conversations. "
              "Feel free to reach out — I'll do my best to get back to you.",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 40),
          const Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _ContactButton(
                label: 'Email Me',
                icon: Icons.mail_outline,
                url: 'mailto:hello@lyndonamat.com',
                primary: true,
              ),
              _ContactButton(
                label: 'GitHub',
                icon: Icons.code,
                url: 'https://github.com/amatlynd',
              ),
              _ContactButton(
                label: 'LinkedIn',
                icon: Icons.person_outline,
                url: 'https://linkedin.com/in/lyndonamat',
              ),
            ],
          ),
          const SizedBox(height: 64),
          const Divider(color: AppTheme.border),
          const SizedBox(height: 24),
          Text(
            '© ${DateTime.now().year} Lyndon Amat. Built with Flutter.',
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String url;
  final bool primary;

  const _ContactButton({
    required this.label,
    required this.icon,
    required this.url,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 8),
        Text(label),
      ],
    );

    final button = primary
        ? ElevatedButton(
            onPressed: () => launchUrl(Uri.parse(url)),
            child: child,
          )
        : OutlinedButton(
            onPressed: () => launchUrl(Uri.parse(url)),
            child: child,
          );

    return HoverScale(child: button);
  }
}
