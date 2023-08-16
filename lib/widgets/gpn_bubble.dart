import 'package:flutter/material.dart';

class GpnBubble extends StatelessWidget {
  final Widget? child;
  const GpnBubble({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: child,
    );
  }
}
