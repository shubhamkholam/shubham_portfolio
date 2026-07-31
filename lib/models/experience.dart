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
      company: 'Prometteur Solutions',
      role: 'Software Development Engineer',
      location: 'Pune, Maharashtra, India',
      startDate: '2021',
      endDate: null,
      isCurrent: true,
      responsibilities: [
        'Developing cross-platform mobile applications using Flutter',
        'Implementing clean architecture and best practices',
        'Leading a team of 3-5 Flutter developers',
        'Code reviews and mentoring junior developers',
        'Collaborating with product and design teams',
      ],
      achievements: [
        'Successfully delivered 10+ production-ready applications',
        'Improved app performance by 40% through optimization',
        'Implemented CI/CD pipelines reducing deployment time by 60%',
        'Received "Best Performer" award in 2023',
      ],
    ),
  ];
}
