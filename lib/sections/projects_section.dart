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
        final columns = constraints.maxWidth > 1100 ? 3 : 2;
        final spacing = 24.0;
        final cardWidth =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;

        final rows = <Widget>[];
        for (var i = 0; i < projects.length; i += columns) {
          final rowCards = <Widget>[];
          for (var j = 0; j < columns && i + j < projects.length; j++) {
            rowCards.add(
              SizedBox(width: cardWidth, child: ProjectCard(project: projects[i + j])),
            );
            if (j < columns - 1) rowCards.add(SizedBox(width: spacing));
          }
          rows.add(Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowCards,
          ));
          if (i + columns < projects.length) rows.add(SizedBox(height: spacing));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rows,
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
