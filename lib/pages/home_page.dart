import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/projects_section.dart';
import '../sections/contact_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        onHeroTap: () => _scrollTo(_heroKey),
        onAboutTap: () => _scrollTo(_aboutKey),
        onProjectsTap: () => _scrollTo(_projectsKey),
        onContactTap: () => _scrollTo(_contactKey),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            KeyedSubtree(
              key: _heroKey,
              child: HeroSection(
                onViewWork: () => _scrollTo(_projectsKey),
              ),
            ),
            KeyedSubtree(
              key: _aboutKey,
              child: const AboutSection(),
            ),
            KeyedSubtree(
              key: _projectsKey,
              child: const ProjectsSection(),
            ),
            KeyedSubtree(
              key: _contactKey,
              child: const ContactSection(),
            ),
          ],
        ),
      ),
    );
  }
}
