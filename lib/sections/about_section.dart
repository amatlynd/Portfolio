import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _Bio(context: context)),
                const SizedBox(width: 80),
                const Expanded(flex: 2, child: _SkillsColumn()),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Bio(context: context),
                const SizedBox(height: 48),
                const _SkillsColumn(),
              ],
            ),
    );
  }
}

class _Bio extends StatelessWidget {
  final BuildContext context;

  const _Bio({required this.context});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About Me', style: Theme.of(context).textTheme.displayMedium),
        const SizedBox(height: 24),
        Text(
          "I'm a software developer who enjoys crafting clean, performant applications "
          "across mobile and web platforms. I care about the details — from smooth "
          "animations to intuitive UX — and love turning complex problems into simple, "
          "elegant solutions.",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        Text(
          "When I'm not coding, you'll find me exploring new technologies, contributing "
          "to open source, or working on side projects that scratch my own itch.",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class _SkillsColumn extends StatelessWidget {
  final List<_SkillGroup> groups = const [
    _SkillGroup(
      label: 'Languages',
      skills: ['Dart', 'JavaScript', 'TypeScript', 'Python'],
    ),
    _SkillGroup(
      label: 'Frameworks',
      skills: ['Flutter', 'React', 'Node.js'],
    ),
    _SkillGroup(
      label: 'Tools',
      skills: ['Git', 'Firebase', 'Figma', 'VS Code'],
    ),
  ];

  const _SkillsColumn();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: groups
          .map((g) => Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: _SkillGroupWidget(group: g),
              ))
          .toList(),
    );
  }
}

class _SkillGroup {
  final String label;
  final List<String> skills;

  const _SkillGroup({required this.label, required this.skills});
}

class _SkillGroupWidget extends StatelessWidget {
  final _SkillGroup group;

  const _SkillGroupWidget({required this.group});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          group.label.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            color: AppTheme.accent,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: group.skills
              .map((s) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppTheme.border),
                    ),
                    child: Text(
                      s,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
