/// Project model for displaying portfolio projects
class Project {
  final String title;
  final String description;
  final String category;
  final List<String> features;
  final List<String> techStack;
  final String? githubUrl;
  final String? liveDemoUrl;
  final String? caseStudyUrl;
  final String? imagePath;

  Project({
    required this.title,
    required this.description,
    required this.category,
    required this.features,
    required this.techStack,
    this.githubUrl,
    this.liveDemoUrl,
    this.caseStudyUrl,
    this.imagePath,
  });
}

/// Predefined projects data
class ProjectsData {
  static final List<Project> projects = [
    Project(
      title: 'SeeU App',
      description: 'A modern dating and matchmaking platform connecting people based on interests and preferences.',
      category: 'Flutter',
      features: [
        'Real-time chat with WebSocket',
        'Advanced matching algorithm',
        'Profile verification system',
        'Location-based matching',
        'Video calling integration',
        'Push notifications',
      ],
      techStack: ['Flutter', 'Firebase', 'WebSocket', 'Google Maps', 'GetX'],
      githubUrl: 'https://github.com/shubhamkholam/seeu-app',
      liveDemoUrl: 'https://seeu-app-demo.web.app',
      caseStudyUrl: '#',
    ),
    Project(
      title: 'EasyScores',
      description: 'Sports prediction platform for football, cricket, and basketball enthusiasts.',
      category: 'API',
      features: [
        'Live score updates',
        'Prediction analytics',
        'Leaderboard system',
        'Social sharing',
        'Expert predictions',
        'Statistical analysis',
      ],
      techStack: ['Flutter', 'REST API', 'Bloc', 'Hive', 'CI/CD'],
      githubUrl: 'https://github.com/shubhamkholam/easyscores',
      liveDemoUrl: 'https://easyscores-demo.web.app',
      caseStudyUrl: '#',
    ),
    Project(
      title: 'ALS Mobility',
      description: 'Electric vehicle charging platform with real-time station availability and booking.',
      category: 'Firebase',
      features: [
        'Station finder with maps',
        'Real-time availability',
        'Booking system',
        'Payment integration',
        'Charging history',
        'Route planning',
      ],
      techStack: ['Flutter', 'Firebase', 'Google Maps', 'Payment Gateway', 'Riverpod'],
      githubUrl: 'https://github.com/shubhamkholam/als-mobility',
      liveDemoUrl: 'https://als-mobility-demo.web.app',
      caseStudyUrl: '#',
    ),
    Project(
      title: 'Go Bet',
      description: 'Comprehensive sports betting application with live odds and secure transactions.',
      category: 'Flutter',
      features: [
        'Live betting odds',
        'Multiple sports support',
        'Secure payment gateway',
        'User authentication',
        'Bet history tracking',
        'Real-time notifications',
      ],
      techStack: ['Flutter', 'Firebase', 'REST API', 'Provider', 'SQLite'],
      githubUrl: 'https://github.com/shubhamkholam/go-bet',
      liveDemoUrl: 'https://go-bet-demo.web.app',
      caseStudyUrl: '#',
    ),
    Project(
      title: 'E-Medicare',
      description: 'Healthcare management system for patients and doctors with telemedicine features.',
      category: 'Firebase',
      features: [
        'Video consultations',
        'Appointment booking',
        'Prescription management',
        'Health records',
        'Medicine reminders',
        'Lab reports integration',
      ],
      techStack: ['Flutter', 'Firebase', 'WebSocket', 'GetX', 'Hive'],
      githubUrl: 'https://github.com/shubhamkholam/e-medicare',
      liveDemoUrl: 'https://e-medicare-demo.web.app',
      caseStudyUrl: '#',
    ),
    Project(
      title: 'Smart Ship Hub',
      description: 'Logistics and shipping management platform for tracking and managing shipments.',
      category: 'API',
      features: [
        'Real-time tracking',
        'Route optimization',
        'Warehouse management',
        'Inventory tracking',
        'Analytics dashboard',
        'Multi-carrier support',
      ],
      techStack: ['Flutter', 'REST API', 'Bloc', 'SQLite', 'Google Maps'],
      githubUrl: 'https://github.com/shubhamkholam/smart-ship-hub',
      liveDemoUrl: 'https://smart-ship-hub-demo.web.app',
      caseStudyUrl: '#',
    ),
    Project(
      title: 'Recipe App',
      description: 'Beautiful recipe discovery app with step-by-step cooking instructions.',
      category: 'UI',
      features: [
        'Recipe search',
        'Ingredient-based suggestions',
        'Step-by-step instructions',
        'Video tutorials',
        'Favorites collection',
        'Meal planning',
      ],
      techStack: ['Flutter', 'REST API', 'Provider', 'Hive', 'Lottie'],
      githubUrl: 'https://github.com/shubhamkholam/recipe-app',
      liveDemoUrl: 'https://recipe-app-demo.web.app',
      caseStudyUrl: '#',
    ),
    Project(
      title: 'SarvaGram',
      description: 'Rural development platform connecting villages with government services.',
      category: 'Open Source',
      features: [
        'Government scheme information',
        'Application tracking',
        'Document management',
        'Community forum',
        'News and updates',
        'Multi-language support',
      ],
      techStack: ['Flutter', 'Firebase', 'REST API', 'Riverpod', 'CI/CD'],
      githubUrl: 'https://github.com/shubhamkholam/sarvagram',
      liveDemoUrl: 'https://sarvagram-demo.web.app',
      caseStudyUrl: '#',
    ),
  ];

  static List<String> get categories {
    return projects.map((project) => project.category).toSet().toList();
  }

  static List<Project> getProjectsByCategory(String category) {
    return projects.where((project) => project.category == category).toList();
  }
}
