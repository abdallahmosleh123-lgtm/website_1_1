// lib/widgets/navbar.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'e_logo.dart';

class NavBar extends StatefulWidget {
  final ScrollController scrollCtrl;
  final GlobalKey productsKey;
  final GlobalKey aboutKey;
  final GlobalKey contactKey;

  const NavBar({
    super.key,
    required this.scrollCtrl,
    required this.productsKey,
    required this.aboutKey,
    required this.contactKey,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollCtrl.addListener(() {
      final s = widget.scrollCtrl.offset > 60;
      if (s != _scrolled) setState(() => _scrolled = s);
    });
  }

  void _goto(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic);
    }
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width > 750;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color:
          _scrolled ? Colors.white.withValues(alpha: 0.97) : Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: wide ? 48 : 20, vertical: 12),
      child: Row(children: [
        const ELogoWidget(size: 42),
        const SizedBox(width: 10),
        ShaderMask(
          shaderCallback: (b) => AppTheme.brandGradient.createShader(b),
          child: Text("emy's",
              style: GoogleFonts.playfairDisplay(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
        ),
        const Spacer(),
        if (wide) ...[
          _Link('Products', () => _goto(widget.productsKey)),
          _Link('About Us', () => _goto(widget.aboutKey)),
          _Link('Contact Us', () => _goto(widget.contactKey)),
          const SizedBox(width: 16),
        ],
        _OrderBtn(() => _goto(widget.contactKey)),
      ]),
    );
  }
}

class _Link extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _Link(this.label, this.onTap);

  @override
  State<_Link> createState() => _LinkState();
}

class _LinkState extends State<_Link> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 180),
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _h ? AppTheme.pink : AppTheme.textMid,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

class _OrderBtn extends StatefulWidget {
  final VoidCallback onTap;
  const _OrderBtn(this.onTap);

  @override
  State<_OrderBtn> createState() => _OrderBtnState();
}

class _OrderBtnState extends State<_OrderBtn> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          decoration: BoxDecoration(
            gradient: AppTheme.brandGradient,
            borderRadius: BorderRadius.circular(30),
            boxShadow: _h
                ? [
                    BoxShadow(
                        color: AppTheme.pink.withValues(alpha: 0.4),
                        blurRadius: 18,
                        spreadRadius: 1)
                  ]
                : [],
          ),
          child: Text('Order Now',
              style: GoogleFonts.dmSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
        ),
      ),
    );
  }
}
