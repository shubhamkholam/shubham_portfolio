import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'core/widgets/animated_mesh_background.dart';
import 'core/widgets/premium_navbar.dart';
import 'features/home/hero_section.dart';
import 'features/about/about_section.dart';
import 'features/skills/skills_section.dart';
import 'features/experience/experience_section.dart';
import 'features/projects/projects_section.dart';
import 'features/achievements/achievements_section.dart';
import 'features/contact/contact_section.dart';
import 'core/widgets/footer.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Shubham Kholam - Senior Flutter Developer',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const PortfolioHomePage(),
          );
        },
      ),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<NavItem> _navItems = [
    NavItem(id: 'home', label: 'Home'),
    NavItem(id: 'about', label: 'About'),
    NavItem(id: 'skills', label: 'Skills'),
    NavItem(id: 'experience', label: 'Experience'),
    NavItem(id: 'projects', label: 'Projects'),
    NavItem(id: 'contact', label: 'Contact'),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: AnimatedMeshBackground(
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Hero Section
                SliverToBoxAdapter(
                  key: _navItems[0].key,
                  child: HeroSection(),
                ),

                // About Section
                SliverToBoxAdapter(
                  key: _navItems[1].key,
                  child: AboutSection(),
                ),

                // Skills Section
                SliverToBoxAdapter(
                  key: _navItems[2].key,
                  child: SkillsSection(),
                ),

                // Experience Section
                SliverToBoxAdapter(
                  key: _navItems[3].key,
                  child: ExperienceSection(),
                ),

                // Achievements Section
                SliverToBoxAdapter(child: AchievementsSection()),

                // Projects Section
                SliverToBoxAdapter(
                  key: _navItems[4].key,
                  child: ProjectsSection(),
                ),

                // Contact Section
                SliverToBoxAdapter(
                  key: _navItems[5].key,
                  child: ContactSection(),
                ),

                // Footer
                SliverToBoxAdapter(child: Footer()),
              ],
            ),
            // Floating Navbar
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Center(
                child: PremiumNavbar(
                  scrollController: _scrollController,
                  items: _navItems,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
