import 'package:flutter/material.dart';

/// Wraps any widget with a subtle scale + lift animation on hover.
class HoverScale extends StatefulWidget {
  final Widget child;
  final double scale;
  final double translateY;
  final Duration duration;

  const HoverScale({
    super.key,
    required this.child,
    this.scale = 1.04,
    this.translateY = -2,
    this.duration = const Duration(milliseconds: 150),
  });

  @override
  State<HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<HoverScale> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? widget.scale : 1.0,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: AnimatedSlide(
          offset: _hovered ? Offset(0, widget.translateY / 100) : Offset.zero,
          duration: widget.duration,
          curve: Curves.easeOut,
          child: widget.child,
        ),
      ),
    );
  }
}
