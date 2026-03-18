import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/projects_data.dart';
import '../theme/app_theme.dart';
import 'hover_scale.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(
              project.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.tags
                  .map((tag) => _TagChip(label: tag))
                  .toList(),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                if (project.githubUrl != null)
                  _LinkButton(
                    label: 'GitHub',
                    icon: Icons.code,
                    url: project.githubUrl!,
                  ),
                if (project.url != null) ...[
                  const SizedBox(width: 12),
                  _LinkButton(
                    label: 'Live',
                    icon: Icons.open_in_new,
                    url: project.url!,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;

  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.border),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppTheme.textSecondary,
        ),
      ),
    );
  }
}

class _LinkButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String url;

  const _LinkButton({required this.label, required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return HoverScale(
      child: OutlinedButton.icon(
        onPressed: () => launchUrl(Uri.parse(url)),
        icon: Icon(icon, size: 16),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
