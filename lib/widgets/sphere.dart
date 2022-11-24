import 'package:flutter/material.dart';
import 'package:glassmorphic_loona_clock/tools/helper.dart';

class Sphere extends StatefulWidget {
  final double size;
  final Color color;

  const Sphere({super.key, required this.size, required this.color});

  @override
  State<Sphere> createState() => _SphereState();
}

class _SphereState extends State<Sphere> {
  @override
  Widget build(BuildContext context) {
    double _size = widget.size;
    Color _color = widget.color;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: _size,
          height: _size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_size),
            gradient: LinearGradient(
              begin: const Alignment(.5, -1.0),
              end: const Alignment(.5, 1.0),
              colors: [
                _color.mix(Colors.white, .32),
                _color.mix(Colors.black, .24),
              ],
              stops: const [0.0, 1.0],
            ),
          ),
        ),
        /*
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size),
            gradient: RadialGradient(
              center: Alignment(-0.3, -0.3),
              colors: [
                Colors.white.withOpacity(.32),
                Colors.black.withOpacity(.24),
              ],
            ),
          ),
        ),
        */
      ],
    );
  }
}
