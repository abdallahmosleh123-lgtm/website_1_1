// lib/pages/hero_section.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class HeroSection extends StatefulWidget {
  final bool visible;
  const HeroSection({super.key, required this.visible});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 900));
  late final Animation<double> _fade =
      CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
  late final Animation<double> _slide = Tween<double>(begin: 50, end: 0)
      .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

  @override
  void didUpdateWidget(HeroSection old) {
    super.didUpdateWidget(old);
    if (widget.visible && !old.visible) _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width > 900;
    final sh = MediaQuery.of(context).size.height;

    return Container(
      constraints: BoxConstraints(minHeight: sh),
      decoration: const BoxDecoration(gradient: AppTheme.heroGradient),
      child: Stack(children: [
        const Positioned(
            top: -80,
            right: -60,
            child: _Blob(
                size: 420, color: Color(0xFFF5E6FF))), // لون ثابت بديل للشفافية
        const Positioned(
            bottom: -40,
            left: -80,
            child: _Blob(
                size: 320, color: Color(0xFFFDE8F0))), // لون ثابت بديل للشفافية
        Positioned(
            top: sh * 0.3,
            right: wide ? 80 : -40,
            child: const _Blob(
                size: 200, color: Color(0xFFFFF7DB))), // لون ثابت بديل للشفافية
        const Positioned(top: 160, right: 200, child: _Sparkle(size: 18)),
        const Positioned(top: 280, right: 120, child: _Sparkle(size: 10)),
        const Positioned(bottom: 200, left: 160, child: _Sparkle(size: 14)),
        Padding(
          padding: EdgeInsets.fromLTRB(wide ? 80 : 28, 130, wide ? 80 : 28, 80),
          child: AnimatedBuilder(
            animation: _ctrl,
            builder: (_, child) => FadeTransition(
              opacity: _fade,
              child: Transform.translate(
                  offset: Offset(0, _slide.value), child: child),
            ),
            child: wide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 6, child: _heroText(wide)),
                      const SizedBox(width: 60),
                      Expanded(flex: 5, child: _heroVisual()),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _heroText(wide),
                      const SizedBox(height: 48),
                      _heroVisual(),
                    ],
                  ),
          ),
        ),
      ]),
    );
  }

  Widget _heroText(bool wide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color:
                const Color(0xFFFDE8F0), // بديل AppTheme.pink.withOpacity(0.1)
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
                color: const Color(0xFFFDB9D0)), // بديل withOpacity(0.3)
          ),
          child: Text('✨  GLOW. SHINE. RADIATE.', style: AppTheme.labelTag),
        ),
        const SizedBox(height: 28),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'Beauty Made\nFor ',
              style: AppTheme.displayLarge.copyWith(fontSize: wide ? 64 : 40),
            ),
            WidgetSpan(
              child: ShaderMask(
                shaderCallback: (b) => AppTheme.brandGradient.createShader(b),
                child: Text('You.',
                    style: AppTheme.displayLarge.copyWith(
                        fontSize: wide ? 64 : 40, color: Colors.white)),
              ),
            ),
          ]),
        ),
        const SizedBox(height: 24),
        Text(
          "Emy's Cosmetics brings you luxurious, skin-loving formulas crafted to make every woman feel radiant, confident, and effortlessly beautiful.",
          style: AppTheme.bodyLarge.copyWith(fontSize: wide ? 17 : 15),
        ),
        const SizedBox(height: 40),
        const Wrap(spacing: 16, runSpacing: 14, children: [
          _HeroCTA(label: 'Shop Products', primary: true),
          _HeroCTA(label: 'Our Story', primary: false),
        ]),
        const SizedBox(height: 52),
        const Wrap(spacing: 40, runSpacing: 20, children: [
          _Stat(num: '50+', label: 'Products'),
          _Stat(num: '10K+', label: 'Happy Clients'),
          _Stat(num: '100%', label: 'Cruelty-Free'),
        ]),
      ],
    );
  }

  Widget _heroVisual() {
    return Center(
      child: Container(
        width: 320,
        height: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          gradient: const LinearGradient(
            colors: [Color(0xFFFFD6E8), Color(0xFFE8D6FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(alignment: Alignment.center, children: [
          Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: const Color(0xFFFDD0E0), width: 1), // بديل withOpacity
            ),
          ),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: const Color(0xFFEBD4FF), width: 1), // بديل withOpacity
            ),
          ),
          Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppTheme.brandGradient,
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xFFFDA8C5), // بديل withOpacity(0.4)
                      blurRadius: 30,
                      spreadRadius: 5)
                ],
              ),
              child: const Center(
                child: Text('✦',
                    style: TextStyle(fontSize: 48, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            Text('New Collection',
                style: GoogleFonts.dmSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.pink)),
            Text('Spring 2025',
                style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textDark)),
          ]),
        ]),
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  final double size;
  final Color color;

  // تم حذف الـ opacity هنا علشان الكود يبقى خفيف ومتوافق مع الويب 100%
  const _Blob({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color, // لون ثابت ناعم
      ),
    );
  }
}

class _Sparkle extends StatelessWidget {
  final double size;
  const _Sparkle({required this.size});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (b) => AppTheme.brandGradient.createShader(b),
      child: Text('✦', style: TextStyle(fontSize: size, color: Colors.white)),
    );
  }
}

class _HeroCTA extends StatefulWidget {
  final String label;
  final bool primary;
  const _HeroCTA({required this.label, required this.primary});

  @override
  State<_HeroCTA> createState() => _HeroCTAState();
}

class _HeroCTAState extends State<_HeroCTA> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
          decoration: BoxDecoration(
            gradient: widget.primary ? AppTheme.brandGradient : null,
            border: widget.primary
                ? null
                : Border.all(
                    color: _h
                        ? AppTheme.pink
                        : const Color(0xFFFDA8C5)), // بديل withOpacity
            borderRadius: BorderRadius.circular(30),
            boxShadow: widget.primary && _h
                ? const [
                    BoxShadow(
                        color: Color(0xFFFDA8C5),
                        blurRadius: 20) // بديل withOpacity
                  ]
                : [],
          ),
          child: Text(widget.label,
              style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: widget.primary ? Colors.white : AppTheme.pink)),
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String num, label;
  const _Stat({required this.num, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ShaderMask(
        shaderCallback: (b) => AppTheme.brandGradient.createShader(b),
        child: Text(num,
            style: GoogleFonts.playfairDisplay(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
      ),
      Text(label, style: AppTheme.bodyMedium),
    ]);
  }
}
