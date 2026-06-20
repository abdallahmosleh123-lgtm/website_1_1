// lib/pages/splash_screen.dart
import 'package:flutter/material.dart';
import '../widget/e_logo.dart'; // المسار سليم زي ما إنت عدلته

class SplashScreen extends StatefulWidget {
  final VoidCallback onDone;
  const SplashScreen({super.key, required this.onDone});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _appearCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 650));
  late final Animation<double> _scaleIn =
      CurvedAnimation(parent: _appearCtrl, curve: Curves.elasticOut);
  late final Animation<double> _fadeIn = Tween<double>(begin: 0, end: 1)
      .animate(CurvedAnimation(
          parent: _appearCtrl,
          curve: const Interval(0.0, 0.5, curve: Curves.easeIn)));

  late final AnimationController _shimmerCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 900));
  late final Animation<double> _shimmer = Tween<double>(begin: -1.5, end: 2.5)
      .animate(CurvedAnimation(parent: _shimmerCtrl, curve: Curves.easeInOut));

  late final AnimationController _moveCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 800));
  late final Animation<double> _moveT =
      CurvedAnimation(parent: _moveCtrl, curve: Curves.easeInCubic);

  late final AnimationController _exitCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 450));
  late final Animation<double> _exitFade = Tween<double>(begin: 1, end: 0)
      .animate(CurvedAnimation(parent: _exitCtrl, curve: Curves.easeOut));

  @override
  void initState() {
    super.initState();
    _runSequence();
  }

  Future<void> _runSequence() async {
    await Future.delayed(const Duration(milliseconds: 250));
    _appearCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 750));
    _shimmerCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 1000));
    _moveCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 650));
    _exitCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 450));
    widget.onDone();
  }

  @override
  void dispose() {
    _appearCtrl.dispose();
    _shimmerCtrl.dispose();
    _moveCtrl.dispose();
    _exitCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    final targetDY = -(sh / 2) + 38;
    final targetDX = -(sw / 2) + (sw > 800 ? 56 : 24);

    return AnimatedBuilder(
      animation:
          Listenable.merge([_appearCtrl, _shimmerCtrl, _moveCtrl, _exitCtrl]),
      builder: (ctx, _) {
        final t = _moveT.value;
        final dy = t * targetDY;
        final dx = t * targetDX;
        final scale = 1.0 - t * 0.58;

        return FadeTransition(
          opacity: _exitFade,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(children: [
              Center(
                child: Opacity(
                  opacity:
                      (1 - t) * _fadeIn.value, // شيلنا الـ 0.25 عشان تبقى أوضح
                  child: Container(
                    width: 380,
                    height: 380,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(
                          0xFFFDE8F0), // لون ناعم وثابت بدل الجراديانت الشفاف
                    ),
                  ),
                ),
              ),
              Center(
                child: Transform.translate(
                  offset: Offset(dx, dy),
                  child: Transform.scale(
                    scale: scale,
                    child: FadeTransition(
                      opacity: _fadeIn,
                      child: ScaleTransition(
                        scale: _scaleIn,
                        child: _LogoWithShimmer(shimmer: _shimmer),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}

class _LogoWithShimmer extends StatelessWidget {
  final Animation<double> shimmer;
  const _LogoWithShimmer({required this.shimmer});

  @override
  Widget build(BuildContext context) {
    // The old ShaderMask + white Container shimmer effect rendered as a
    // solid opaque white block on Flutter Web instead of a soft light
    // sweep, hiding the logo. Removed — the logo now renders cleanly.
    return const ELogoWidget(size: 150, showText: true);
  }
}
