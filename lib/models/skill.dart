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
    Skill(name: 'Firebase', icon: '🔥', category: 'Firebase', proficiency: 90),
    Skill(name: 'Firestore', icon: '📄', category: 'Firebase', proficiency: 88),
    Skill(
      name: 'Firebase Auth',
      icon: '🔐',
      category: 'Firebase',
      proficiency: 90,
    ),
    Skill(
      name: 'Firebase Storage',
      icon: '☁️',
      category: 'Firebase',
      proficiency: 85,
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
      proficiency: 90,
    ),
    Skill(
      name: 'Provider',
      icon: '📦',
      category: 'State Management',
      proficiency: 92,
    ),

    // Architecture
    Skill(
      name: 'Clean Architecture',
      icon: '🏗️',
      category: 'Architecture',
      proficiency: 90,
    ),
    Skill(name: 'MVVM', icon: '🔄', category: 'Architecture', proficiency: 88),
    Skill(
      name: 'Dependency Injection',
      icon: '💉',
      category: 'Architecture',
      proficiency: 85,
    ),

    // APIs & Data
    Skill(name: 'REST API', icon: '🌐', category: 'API', proficiency: 92),
    Skill(name: 'GraphQL', icon: '📊', category: 'API', proficiency: 80),
    Skill(name: 'WebSocket', icon: '🔌', category: 'API', proficiency: 82),

    // Databases
    Skill(name: 'SQLite', icon: '💾', category: 'Database', proficiency: 85),
    Skill(name: 'Hive', icon: '🐝', category: 'Database', proficiency: 88),

    // Platforms
    Skill(name: 'Android', icon: '🤖', category: 'Platform', proficiency: 90),
    Skill(name: 'iOS', icon: '🍎', category: 'Platform', proficiency: 85),

    // Tools
    Skill(name: 'Git', icon: '📚', category: 'Tools', proficiency: 92),
    Skill(name: 'GitHub', icon: '🐙', category: 'Tools', proficiency: 90),
    Skill(name: 'CI/CD', icon: '🔄', category: 'Tools', proficiency: 85),
    Skill(name: 'Google Maps', icon: '🗺️', category: 'Tools', proficiency: 82),
    Skill(
      name: 'Payment Gateway',
      icon: '💳',
      category: 'Tools',
      proficiency: 80,
    ),
  ];

  static List<String> get categories {
    return skills.map((skill) => skill.category).toSet().toList();
  }

  static List<Skill> getSkillsByCategory(String category) {
    return skills.where((skill) => skill.category == category).toList();
  }
}
