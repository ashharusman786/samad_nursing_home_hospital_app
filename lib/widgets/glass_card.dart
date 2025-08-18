import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../utils/app_theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double borderRadius;
  final double blur;
  final double opacity;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.onTap,
    this.borderRadius = 20,
    this.blur = 20,
    this.opacity = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: GestureDetector(
        onTap: onTap,
        child: GlassmorphicContainer(
          width: width ?? double.infinity,
          height: height ?? double.infinity,
          borderRadius: borderRadius,
          blur: blur,
          alignment: Alignment.bottomCenter,
          border: 1,
          linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(opacity),
              Colors.white.withOpacity(opacity * 0.5),
            ],
          ),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.2),
            ],
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(20),
            child: child,
          ),
        ),
      ),
    );
  }
}