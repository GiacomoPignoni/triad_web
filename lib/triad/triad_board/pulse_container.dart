import 'package:flutter/material.dart';

class PulseContainer extends StatefulWidget {
  final bool pulse;
  final bool shadow;
  final BorderRadius? borderRadius;
  final Widget child;
  final Alignment? alignment;
  final Color color;
  final Duration pulseDuration;

  PulseContainer({
    required this.child,
    required this.color,
    this.pulse = false,
    this.shadow = true,
    this.borderRadius,
    this.alignment,
    this.pulseDuration = const Duration(milliseconds: 500)
  });

  @override
  _PulseContainerState createState() => _PulseContainerState();
}

class _PulseContainerState extends State<PulseContainer> with SingleTickerProviderStateMixin {
  late AnimationController pulseCtrl;
  late Animation<double> pulseAnim;

  bool pulse = false;

  @override
  void initState() {
    super.initState();
    pulseCtrl = AnimationController(
      vsync: this,
      duration: widget.pulseDuration,
    );
    pulseAnim = CurveTween(
      curve: Curves.easeOut
    ).animate(pulseCtrl)..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    if(pulse != widget.pulse) {
      if(widget.pulse) {
        pulseCtrl.repeat(reverse: true);
        pulse = true;
      } else {
        pulseCtrl.stop();
        pulseCtrl.reset();
        pulse = false;
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Color.lerp(widget.color, widget.color.withAlpha(150), pulseAnim.value),
        boxShadow: (widget.shadow) ? [
          BoxShadow(
            color: Color.lerp(widget.color, widget.color.withAlpha(100), pulseAnim.value)!,
            blurRadius: 10.0,
            spreadRadius: 4.0,
            offset: Offset(
              0.0,
              0.0,
            ),
          )
        ] : [],
        borderRadius: widget.borderRadius
      ),
      alignment: widget.alignment,
      child: widget.child
    );
  }

  @override
  void dispose() {
    pulseCtrl.dispose();
    super.dispose();
  }
}