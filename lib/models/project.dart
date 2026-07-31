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
  final String? playStoreLink;
  final String? appStoreLink;

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
    this.playStoreLink,
    this.appStoreLink,
  });
}

/// Predefined projects data
class ProjectsData {
  static final List<Project> projects = [
    Project(
      title: 'Seeu Dating App',
      description:
          'Location-based social dating application with real-time chat, profile matching, and media sharing.',
      category: 'Dating',
      features: [
        'Real-time chat with WebSocket',
        'Profile matching algorithm',
        'Location-based matching',
        'Media sharing',
        'Video calling integration',
        'Push notifications',
      ],
      techStack: ['Flutter', 'Firebase', 'WebSocket', 'GetX'],
      githubUrl: 'https://github.com/shubhamkholam/seeu-app',
      liveDemoUrl: '#',
      caseStudyUrl: '#',
    ),
    Project(
      title: 'Smart Ship Hub',
      description:
          'Multi-platform logistics app for marine vessel tracking and shore coordination across Android, iOS, and web.',
      category: 'Logistics',
      features: [
        'Real-time marine tracking',
        'Vessel/shore finder',
        'Multi-platform support (Android, iOS, Web)',
        'REST API integration',
        'Real-time data feeds',
        'Route optimization',
      ],
      techStack: ['Flutter', 'REST API', 'Bloc', 'Google Maps'],
      liveDemoUrl: 'https://smartshipweb.com/fo-shore/',
      playStoreLink:
          'https://play.google.com/store/apps/details?id=com.smartship.dashboard',
      appStoreLink:
          'https://apps.apple.com/af/app/smart-ship-hub-remote/id6475711365',
    ),
    Project(
      title: 'GoBet',
      description:
          'Live sports betting platform (France region) with real-time odds updates, wallet management, and secure payment processing.',
      category: 'Sports',
      features: [
        'Live betting odds',
        'Real-time odds updates',
        'Wallet management',
        'Secure payment processing',
        'Multiple sports support',
        'User authentication',
      ],
      techStack: ['Flutter', 'Firebase', 'REST API', 'Payment Gateway'],
      appStoreLink: 'https://apps.apple.com/us/app/go-bet/id6751179062',
    ),
    Project(
      title: 'EasyScores – Easy Live Scores',
      description:
          'Sports score aggregator app delivering real-time match updates using REST APIs and efficient list rendering.',
      category: 'Sports',
      features: [
        'Real-time match updates',
        'Live score aggregation',
        'Lazy loading for efficient rendering',
        'Multiple sports support',
        'REST API integration',
        'Statistical analysis',
      ],
      techStack: ['Flutter', 'REST API', 'Bloc', 'Hive'],
      playStoreLink:
          'https://play.google.com/store/apps/details?id=com.easyscores.app',
    ),
    Project(
      title: 'E-Medicare',
      description:
          'Healthcare app enabling online doctor consultations, appointment booking, and patient health record management.',
      category: 'Healthcare',
      features: [
        'Online doctor consultations',
        'Appointment booking',
        'Patient health record management',
        'Firebase Auth integration',
        'Firestore integration',
        'Prescription management',
      ],
      techStack: ['Flutter', 'Firebase', 'Firebase Auth', 'Firestore'],
      playStoreLink:
          'https://play.google.com/store/apps/details?id=com.prometteur.emedicar',
      appStoreLink: 'https://apps.apple.com/us/app/e-medicare/id6608977783',
    ),
    Project(
      title: 'Sherpa Tutors',
      description:
          'Educational platform enhancing student-tutor interaction with resource sharing, scheduling, and progress tracking features.',
      category: 'Education',
      features: [
        'Student-tutor interaction',
        'Resource sharing',
        'Scheduling system',
        'Progress tracking',
        'Real-time data sync with Firestore',
        'Educational content delivery',
      ],
      techStack: ['Flutter', 'Firebase', 'Firestore'],
      githubUrl: 'https://github.com/shubhamkholam/sherpa-tutors',
      liveDemoUrl: '#',
      caseStudyUrl: '#',
    ),
    Project(
      title: 'KIMI (Crowdfunding App)',
      description:
          'Full-featured crowdfunding platform with project creation, backer communication, real-time updates, and payment integration on Android, iOS, and web.',
      category: 'Finance',
      features: [
        'Project creation',
        'Backer communication',
        'Real-time updates',
        'Payment integration',
        'Multi-platform support',
        'Crowdfunding workflows',
      ],
      techStack: ['Flutter', 'Firebase', 'Payment Gateway', 'WebSocket'],
      githubUrl: 'https://github.com/shubhamkholam/kimi-crowdfunding',
      liveDemoUrl: '#',
      caseStudyUrl: '#',
    ),
    Project(
      title: 'ALS Mobility (E-Vehicle Charging App)',
      description:
          'EV charging station locator and booking app with map integration and real-time station availability tracking.',
      category: 'Automotive',
      features: [
        'EV charging station locator',
        'Map integration',
        'Real-time station availability',
        'Booking system',
        'Route planning',
        'Charging history',
      ],
      techStack: ['Flutter', 'Firebase', 'Google Maps', 'Riverpod'],
      githubUrl: 'https://github.com/shubhamkholam/als-mobility',
      liveDemoUrl: '#',
      caseStudyUrl: '#',
    ),
    Project(
      title: 'Adda Game',
      description:
          'Real-money multi-gaming platform supporting multiple game modes with secure wallet, in-app payments, and live competitive sessions.',
      category: 'Gaming',
      features: [
        'Real-money gaming',
        'Multiple game modes',
        'Secure wallet',
        'In-app payments',
        'Live competitive sessions',
        'Real-time game state updates',
      ],
      techStack: ['Flutter', 'Firebase', 'Payment Gateway', 'WebSocket'],
      liveDemoUrl: 'http://www.adda.games/',
    ),
    Project(
      title: 'SarvaGram',
      description:
          'Rural commerce and services platform with API integrations, complex UI flows, and local language support.',
      category: 'Social Impact',
      features: [
        'Rural commerce platform',
        'API integrations',
        'Complex UI flows',
        'Local language support',
        'Government services',
        'Community features',
      ],
      techStack: ['Flutter', 'REST API', 'Firebase', 'Riverpod'],
      playStoreLink:
          'https://play.google.com/store/apps/details?id=com.sarvagram.marketplace',
    ),
    Project(
      title: 'Tennis App',
      description:
          'Sports analytics application with domain-specific UI/UX and API integrations.',
      category: 'Lifestyle',
      features: [
        'Domain-specific UI/UX',
        'API integrations',
        'Sports analytics',
      ],
      techStack: ['Flutter', 'REST API', 'Provider', 'Hive'],
      liveDemoUrl: 'https://www.edgeai.pro/',
    ),
    Project(
      title: 'Yaari',
      description:
          'Full-stack e-commerce application with product catalog, cart, checkout, and order tracking features.',
      category: 'E-Commerce',
      features: [
        'Product catalog',
        'Shopping cart',
        'Checkout system',
        'Order tracking',
        'Payment integration',
        'User authentication',
      ],
      techStack: ['Flutter', 'Firebase', 'REST API', 'Payment Gateway'],
      playStoreLink: 'https://play.google.com/store/apps/details?id=com.yaari',
    )
  ];

  static List<String> get categories {
    return projects.map((project) => project.category).toSet().toList();
  }

  static List<Project> getProjectsByCategory(String category) {
    return projects.where((project) => project.category == category).toList();
  }
}
