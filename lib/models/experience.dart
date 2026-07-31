/// Experience model for displaying work experience
class Experience {
  final String company;
  final String role;
  final String location;
  final String startDate;
  final String? endDate;
  final bool isCurrent;
  final List<String> responsibilities;
  final List<String> achievements;

  Experience({
    required this.company,
    required this.role,
    required this.location,
    required this.startDate,
    this.endDate,
    required this.isCurrent,
    required this.responsibilities,
    required this.achievements,
  });
}

/// Predefined experience data
class ExperienceData {
  static final List<Experience> experiences = [
    Experience(
      company: 'Prometteur Solutions Pvt. Ltd.',
      role: 'Software Development Engineer – III (Flutter)',
      location: 'Pune, Maharashtra, India',
      startDate: 'Jul 2023',
      endDate: null,
      isCurrent: true,
      responsibilities: [
        'Architected and shipped multiple high-impact cross-platform applications including Seeu Dating App, EasyScore, Gobet (live sports betting, France region), E-MediCare (healthcare), and KIMI (crowdfunding)',
        'Led full-cycle development of Smart Ship Hub (Vessel/Shore Finder), a logistics platform delivering real-time marine tracking across Android, iOS, and web',
        'Built Sherpa, an interactive educational mobile app enhancing student learning through resource delivery and progress tracking',
        'Developed and deployed a crowdfunding platform on Android, iOS, and web using Flutter\'s multi-platform capabilities',
        'Implemented robust CI/CD pipelines using Fastlane and GitHub Actions, reducing manual deployment effort and improving release cycles',
        'Applied Bloc and Clean Architecture patterns to maintain separation of concerns across all projects',
        'Optimized app performance using Isolates, lazy loading, widget profiling, and efficient Firestore query strategies',
      ],
      achievements: [
        'Delivered 50+ cross-platform Flutter applications across diverse industry verticals',
        'Successfully published multiple apps on both Google Play Store and Apple App Store',
        'Extended Flutter expertise beyond mobile to Flutter Web, delivering multi-platform solutions',
        'Implemented real-time communication systems using WebSockets and Socket.IO',
        'Streamlined deployments with Fastlane + GitHub Actions CI/CD integration',
      ],
    ),
    Experience(
      company: 'Fermion Infotech Pvt. Ltd.',
      role: 'Mobile App Developer',
      location: 'Mumbai, Maharashtra, India',
      startDate: 'Oct 2021',
      endDate: 'Nov 2022',
      isCurrent: false,
      responsibilities: [
        'Developed Adda Games, a real-money multi-gaming platform enabling competitive gameplay with real-cash rewards',
        'Implemented secure wallet, payment gateway integration, and real-time game state updates',
        'Built direct messaging, public project channels, and push notification system using Firebase Cloud Messaging (FCM)',
        'Designed responsive UI components aligned with product specifications',
      ],
      achievements: [
        'Successfully delivered real-money gaming platform with secure payment flows',
        'Improved user retention metrics through intuitive gaming interface design',
        'Implemented reliable user engagement and communication systems',
      ],
    ),
    Experience(
      company: 'SVR Infotech Pvt. Ltd.',
      role: 'Flutter Developer',
      location: 'Pune, Maharashtra, India',
      startDate: 'Oct 2019',
      endDate: 'Jul 2021',
      isCurrent: false,
      responsibilities: [
        'Designed and implemented the chat system architecture and user interface for a crowdfunding communication module',
        'Integrated WebSockets and Socket.IO to deliver real-time bidirectional messaging',
        'Established foundational Flutter development practices for the team including state management conventions',
        'Created reusable widget libraries to accelerate team productivity',
      ],
      achievements: [
        'Built real-time chat system enabling seamless interaction between project creators and backers',
        'Delivered instant notifications and live chat within the application',
        'Accelerated team productivity through reusable component libraries',
      ],
    ),
  ];
}
