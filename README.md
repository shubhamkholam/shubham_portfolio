# Shubham Kholam - Senior Flutter Developer Portfolio

A world-class, production-ready Flutter Web portfolio website showcasing professional experience, skills, projects, and achievements.

![Flutter](https://img.shields.io/badge/Flutter-3.19.0-blue)
![Dart](https://img.shields.io/badge/Dart-3.3.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![GitHub Pages](https://img.shields.io/badge/deployment-GitHub%20Pages-blue)

## 🚀 Features

- **Modern UI/UX**: Apple-inspired, minimal, glassmorphism design with smooth animations
- **Dark/Light Mode**: Complete theme system with Material 3 design
- **Responsive Design**: Optimized for desktop, tablet, mobile, and ultra-wide screens
- **Animated Sections**: Hero fade, slide animations, scroll reveal, hover effects, parallax, and animated counters
- **SEO Optimized**: Meta tags, Open Graph, Twitter Cards, structured data, sitemap, and robots.txt
- **Performance**: Lazy loading, image optimization, caching, const widgets, and release optimization
- **Clean Architecture**: Feature-first architecture with SOLID principles
- **CI/CD**: Automatic deployment to GitHub Pages using GitHub Actions

## 📋 Sections

1. **Hero Section**: Animated background, gradient, typing animation, profile image, social icons
2. **About**: Professional introduction, experience, technologies, career summary
3. **Skills**: Animated skill cards with category filters and proficiency indicators
4. **Experience**: Beautiful timeline with responsibilities and achievements
5. **Projects**: Glassmorphism cards with hover animations, category filters, and action buttons
6. **Achievements**: Animated counters showcasing key metrics
7. **Contact**: Contact form with social links and contact information
8. **Footer**: Navigation links, social icons, and copyright

## 🛠️ Tech Stack

- **Framework**: Flutter 3.19.0
- **Language**: Dart 3.3.0
- **State Management**: Provider
- **Animations**: flutter_animate, animated_text_kit, lottie
- **Fonts**: google_fonts
- **Utilities**: url_launcher, visibility_detector, flutter_svg
- **Architecture**: Clean Architecture, Feature-first

## 📦 Installation

### Prerequisites

- Flutter SDK 3.19.0 or higher
- Dart SDK 3.3.0 or higher
- Git

### Clone the Repository

```bash
git clone https://github.com/shubhamkholam/shubham_portfolio.git
cd shubham_portfolio
```

### Install Dependencies

```bash
flutter pub get
```

### Run the Application

```bash
flutter run -d chrome
```

### Build for Web

```bash
flutter build web --release
```

## 🏗️ Project Structure

```
lib/
├── core/
│   ├── theme/
│   │   ├── app_theme.dart
│   │   └── theme_provider.dart
│   └── widgets/
│       ├── section_header.dart
│       ├── custom_button.dart
│       ├── scroll_indicator.dart
│       └── footer.dart
├── features/
│   ├── home/
│   │   └── hero_section.dart
│   ├── about/
│   │   └── about_section.dart
│   ├── skills/
│   │   └── skills_section.dart
│   ├── experience/
│   │   └── experience_section.dart
│   ├── projects/
│   │   └── projects_section.dart
│   ├── achievements/
│   │   └── achievements_section.dart
│   └── contact/
│       └── contact_section.dart
├── models/
│   ├── skill.dart
│   ├── project.dart
│   └── experience.dart
└── main.dart
```

## 🎨 Customization

### Update Personal Information

Edit the following files to customize the portfolio with your information:

- **lib/models/skill.dart**: Update skills and proficiency levels
- **lib/models/project.dart**: Update project details
- **lib/models/experience.dart**: Update work experience
- **lib/features/home/hero_section.dart**: Update hero section content
- **lib/features/about/about_section.dart**: Update about section
- **lib/features/contact/contact_section.dart**: Update contact information

### Update Theme Colors

Edit `lib/core/theme/app_theme.dart` to customize the color scheme:

```dart
static const Color _lightPrimary = Color(0xFF1976D2);
static const Color _darkPrimary = Color(0xFFA4C9FF);
```

### Update SEO Meta Tags

Edit `web/index.html` to update SEO meta tags and structured data.

## 🚢 Deployment

### GitHub Pages

The project is configured for automatic deployment to GitHub Pages:

1. Fork or create a new repository on GitHub
2. Update the repository name in `.github/workflows/deploy.yml`
3. Update the base href in `web/index.html` and the build command
4. Push to the main branch
5. GitHub Actions will automatically build and deploy

### Manual Deployment

```bash
flutter build web --release --base-href "/your-repo-name/"
```

Then upload the contents of `build/web/` to your hosting provider.

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👤 Author

**Shubham Kholam**

- LinkedIn: [linkedin.com/in/shubhamkholam](https://linkedin.com/in/shubhamkholam)
- GitHub: [github.com/shubhamkholam](https://github.com/shubhamkholam)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- All the open-source contributors whose packages are used in this project

## 📧 Contact

For inquiries or collaboration opportunities, reach out via:
- Email: shubham@example.com
- LinkedIn: [linkedin.com/in/shubhamkholam](https://linkedin.com/in/shubhamkholam)

---

Built with ❤️ using Flutter
