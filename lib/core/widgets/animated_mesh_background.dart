import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/app_theme.dart';

/// Animated mesh gradient background with floating particles
/// Inspired by Linear, Vercel, and Aurora backgrounds
class AnimatedMeshBackground extends StatefulWidget {
  final Widget? child;
  final bool showParticles;

  const AnimatedMeshBackground({
    super.key,
    this.child,
    this.showParticles = true,
  });

  @override
  State<AnimatedMeshBackground> createState() => _AnimatedMeshBackgroundState();
}

class _AnimatedMeshBackgroundState extends State<AnimatedMeshBackground>
    with TickerProviderStateMixin {
  late List<AnimationController> _blobControllers;
  late List<Animation<double>> _blobAnimations;
  late List<BlobData> _blobs;
  late List<ParticleData> _particles;

  @override
  void initState() {
    super.initState();
    _initBlobs();
    _initParticles();
  }

  void _initBlobs() {
    _blobs = [
      BlobData(
        color: AppTheme.primaryColor.withOpacity(0.4),
        size: 500,
        position: const Offset(0.15, 0.25),
      ),
      BlobData(
        color: AppTheme.secondaryColor.withOpacity(0.35),
        size: 450,
        position: const Offset(0.85, 0.15),
      ),
      BlobData(
        color: AppTheme.accentColor.withOpacity(0.3),
        size: 400,
        position: const Offset(0.5, 0.75),
      ),
      BlobData(
        color: AppTheme.pinkColor.withOpacity(0.25),
        size: 350,
        position: const Offset(0.1, 0.65),
      ),
      BlobData(
        color: AppTheme.primaryColor.withOpacity(0.2),
        size: 300,
        position: const Offset(0.75, 0.85),
      ),
      BlobData(
        color: AppTheme.secondaryColor.withOpacity(0.15),
        size: 250,
        position: const Offset(0.3, 0.5),
      ),
    ];

    _blobControllers = List.generate(
      _blobs.length,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 10000 + index * 1500,
        ),
      ),
    );

    _blobAnimations = _blobControllers.map((controller) {
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOutSine,
        ),
      );
    }).toList();

    for (var controller in _blobControllers) {
      controller.repeat();
    }
  }

  void _initParticles() {
    final random = math.Random();
    _particles = List.generate(
      50,
      (index) => ParticleData(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: random.nextDouble() * 3 + 1,
        speed: random.nextDouble() * 0.5 + 0.2,
        opacity: random.nextDouble() * 0.5 + 0.2,
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _blobControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base gradient background
        Container(
          decoration: BoxDecoration(
            gradient: AppTheme.meshGradient,
          ),
        ),
        // Animated blobs
        ...List.generate(_blobs.length, (index) {
          return AnimatedBuilder(
            animation: _blobAnimations[index],
            builder: (context, child) {
              final animation = _blobAnimations[index].value;
              final blob = _blobs[index];

              return Positioned(
                left: (blob.position.dx +
                        math.sin(animation * 2 * math.pi) * 0.1) *
                    MediaQuery.of(context).size.width,
                top: (blob.position.dy +
                        math.cos(animation * 2 * math.pi) * 0.1) *
                    MediaQuery.of(context).size.height,
                child: Container(
                  width: blob.size,
                  height: blob.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: blob.color,
                  ),
                ),
              );
            },
          );
        }),
        // Floating particles
        if (widget.showParticles)
          ...List.generate(_particles.length, (index) {
            return _ParticleWidget(
              particle: _particles[index],
            );
          }),
        // Content
        if (widget.child != null) widget.child!,
      ],
    );
  }
}

class BlobData {
  final Color color;
  final double size;
  final Offset position;

  BlobData({
    required this.color,
    required this.size,
    required this.position,
  });
}

class ParticleData {
  double x;
  double y;
  final double size;
  final double speed;
  final double opacity;

  ParticleData({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}

class _ParticleWidget extends StatefulWidget {
  final ParticleData particle;

  const _ParticleWidget({required this.particle});

  @override
  State<_ParticleWidget> createState() => _ParticleWidgetState();
}

class _ParticleWidgetState extends State<_ParticleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: (10000 / widget.particle.speed).round(),
      ),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final animation = _controller.value;
        final newY = (widget.particle.y - animation * 0.3) % 1.0;

        return Positioned(
          left: widget.particle.x * MediaQuery.of(context).size.width,
          top: newY * MediaQuery.of(context).size.height,
          child: Container(
            width: widget.particle.size,
            height: widget.particle.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(widget.particle.opacity),
            ),
          ),
        );
      },
    );
  }
}
