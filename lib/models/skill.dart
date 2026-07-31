/// Skill model for displaying technical skills
class Skill {
  final String name;
  final String icon;
  final String category;
  final int proficiency; // 0-100

  Skill({
    required this.name,
    required this.icon,
    required this.category,
    required this.proficiency,
  });
}

/// Predefined skills data
class SkillsData {
  static final List<Skill> skills = [
    // Flutter & Dart
    Skill(name: 'Flutter', icon: '🐦', category: 'Flutter', proficiency: 95),
    Skill(name: 'Dart', icon: '🎯', category: 'Flutter', proficiency: 95),

    // Firebase
    Skill(name: 'Firebase', icon: '🔥', category: 'Firebase', proficiency: 92),
    Skill(name: 'Firestore', icon: '📄', category: 'Firebase', proficiency: 90),
    Skill(
      name: 'Firebase Auth',
      icon: '🔐',
      category: 'Firebase',
      proficiency: 92,
    ),
    Skill(
      name: 'Firebase Storage',
      icon: '☁️',
      category: 'Firebase',
      proficiency: 88,
    ),
    Skill(
      name: 'Cloud Functions',
      icon: '⚙️',
      category: 'Firebase',
      proficiency: 85,
    ),
    Skill(
      name: 'FCM',
      icon: '📱',
      category: 'Firebase',
      proficiency: 90,
    ),

    // State Management
    Skill(
      name: 'GetX',
      icon: '⚡',
      category: 'State Management',
      proficiency: 92,
    ),
    Skill(
      name: 'Riverpod',
      icon: '🏊',
      category: 'State Management',
      proficiency: 88,
    ),
    Skill(
      name: 'Bloc',
      icon: '🧱',
      category: 'State Management',
      proficiency: 92,
    ),
    Skill(
      name: 'Provider',
      icon: '📦',
      category: 'State Management',
      proficiency: 90,
    ),

    // Architecture
    Skill(
      name: 'Clean Architecture',
      icon: '🏗️',
      category: 'Architecture',
      proficiency: 92,
    ),
    Skill(name: 'MVVM', icon: '🔄', category: 'Architecture', proficiency: 90),
    Skill(name: 'MVC', icon: '🎨', category: 'Architecture', proficiency: 85),

    // APIs & Data
    Skill(name: 'REST API', icon: '🌐', category: 'API', proficiency: 92),
    Skill(name: 'JSON', icon: '�', category: 'API', proficiency: 95),
    Skill(name: 'WebSocket', icon: '🔌', category: 'API', proficiency: 88),
    Skill(name: 'Socket.IO', icon: '🔗', category: 'API', proficiency: 85),

    // Databases
    Skill(name: 'SQLite', icon: '💾', category: 'Database', proficiency: 88),
    Skill(name: 'Hive', icon: '🐝', category: 'Database', proficiency: 90),
    Skill(name: 'MySQL', icon: '🗄️', category: 'Database', proficiency: 82),
    Skill(
      name: 'SharedPreferences',
      icon: '📝',
      category: 'Database',
      proficiency: 90,
    ),

    // Platforms
    Skill(name: 'Android', icon: '🤖', category: 'Platform', proficiency: 92),
    Skill(name: 'iOS', icon: '🍎', category: 'Platform', proficiency: 88),
    Skill(
        name: 'Flutter Web', icon: '🌍', category: 'Platform', proficiency: 85),

    // DevOps & Tools
    Skill(name: 'Git', icon: '📚', category: 'DevOps', proficiency: 92),
    Skill(name: 'GitHub', icon: '🐙', category: 'DevOps', proficiency: 90),
    Skill(name: 'GitLab', icon: '🦊', category: 'DevOps', proficiency: 85),
    Skill(name: 'CI/CD', icon: '🔄', category: 'DevOps', proficiency: 88),
    Skill(name: 'Fastlane', icon: '🚀', category: 'DevOps', proficiency: 85),
    Skill(
      name: 'GitHub Actions',
      icon: '⚡',
      category: 'DevOps',
      proficiency: 85,
    ),
    Skill(
      name: 'Android Studio',
      icon: '📱',
      category: 'DevOps',
      proficiency: 95,
    ),
    Skill(name: 'VS Code', icon: '💻', category: 'DevOps', proficiency: 92),
    Skill(name: 'Android SDK', icon: '�️', category: 'DevOps', proficiency: 90),

    // Specializations
    Skill(
      name: 'Performance Optimization',
      icon: '⚡',
      category: 'Specializations',
      proficiency: 90,
    ),
    Skill(
      name: 'Lazy Loading',
      icon: '📥',
      category: 'Specializations',
      proficiency: 92,
    ),
    Skill(
      name: 'Isolates',
      icon: '🔀',
      category: 'Specializations',
      proficiency: 85,
    ),
    Skill(
      name: 'Profiling',
      icon: '📊',
      category: 'Specializations',
      proficiency: 88,
    ),
    Skill(
      name: 'Push Notifications',
      icon: '🔔',
      category: 'Specializations',
      proficiency: 90,
    ),

    // Testing
    Skill(
      name: 'Unit Testing',
      icon: '🧪',
      category: 'Testing',
      proficiency: 85,
    ),
    Skill(
      name: 'Widget Testing',
      icon: '🔬',
      category: 'Testing',
      proficiency: 85,
    ),
    Skill(
      name: 'Play Store Deployment',
      icon: '�',
      category: 'Testing',
      proficiency: 90,
    ),
    Skill(
      name: 'App Store Deployment',
      icon: '🍎',
      category: 'Testing',
      proficiency: 88,
    ),

    // Methodologies
    Skill(
        name: 'Agile', icon: '🏃', category: 'Methodologies', proficiency: 90),
    Skill(
        name: 'Scrum', icon: '📋', category: 'Methodologies', proficiency: 88),
  ];

  static List<String> get categories {
    return skills.map((skill) => skill.category).toSet().toList();
  }

  static List<Skill> getSkillsByCategory(String category) {
    return skills.where((skill) => skill.category == category).toList();
  }
}
