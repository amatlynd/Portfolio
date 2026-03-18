class Project {
  final String title;
  final String description;
  final List<String> tags;
  final String? url;
  final String? githubUrl;

  const Project({
    required this.title,
    required this.description,
    required this.tags,
    this.url,
    this.githubUrl,
  });
}

const List<Project> projects = [
  Project(
    title: 'Portfolio Website',
    description:
        'Personal portfolio website showcasing projects and skills, built with Flutter Web for a responsive, cross-platform experience.',
    tags: ['Flutter', 'Dart', 'Web'],
    githubUrl: 'https://github.com/amatlynd/Portfolio',
  ),
  Project(
    title: 'Mobile App',
    description:
        'A cross-platform mobile application with push notification support, built with Flutter and integrated with Salesforce Marketing Cloud.',
    tags: ['Flutter', 'Dart', 'Push Notifications'],
    githubUrl: 'https://github.com/amatlynd',
  ),
  Project(
    title: 'Project Three',
    description:
        'Add your project description here. Highlight what problem it solves, the tech stack used, and any notable outcomes.',
    tags: ['React', 'Node.js', 'TypeScript'],
    githubUrl: 'https://github.com/amatlynd',
  ),
];
