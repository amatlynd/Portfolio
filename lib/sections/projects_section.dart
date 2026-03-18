import 'package:flutter/material.dart';
import '../data/projects_data.dart';
import '../widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Projects', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 8),
          Text(
            'A selection of things I\'ve built.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 48),
          if (isWide)
            _DesktopGrid()
          else
            _MobileList(),
        ],
      ),
    );
  }
}

class _DesktopGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 1100 ? 3 : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 1.1,
          ),
          itemCount: projects.length,
          itemBuilder: (_, i) => ProjectCard(project: projects[i]),
        );
      },
    );
  }
}

class _MobileList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: projects
          .map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ProjectCard(project: p),
              ))
          .toList(),
    );
  }
}
