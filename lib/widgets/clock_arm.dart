import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:glassmorphic_loona_clock/tools/helper.dart';

class ClockArmLayer extends StatefulWidget {
  final double size;
  final Color secondColor;
  final Color minuteColor;
  final bool debug;

  const ClockArmLayer({
    super.key,
    required this.size,
    required this.secondColor,
    required this.minuteColor,
    this.debug = false,
  });

  @override
  State<ClockArmLayer> createState() => _ClockArmLayerState();
}

class _ClockArmLayerState extends State<ClockArmLayer>
    with SingleTickerProviderStateMixin {
  late final Timer _timer;
  late DateTime _dateTime;
  late final AnimationController _controller;

  late final Animation _animationM;
  late final Animation _animationS;

  double _rotationM = 0;
  double _rotationS = 0;

  double _oldRotationM = 0;
  double _oldRotationS = 0;

  double _deltaRotationM = 0;
  double _deltaRotationS = 0;

  int kH = 0, kM = 0, kS = 0;

  void setTime(Timer timer) {
    _controller.reset();
    _dateTime = DateTime.now();

    kH = _dateTime.hour;
    kM = _dateTime.minute;
    kS = _dateTime.second;

    _oldRotationM = _rotationM;
    _oldRotationS = _rotationS;

    _rotationM = kM / 30 * pi;
    _rotationS = kS / 30 * pi;

    _deltaRotationM = _rotationM - _oldRotationM < 0
        ? 1 / 30 * pi
        : _rotationM - _oldRotationM;
    _deltaRotationS = _rotationS - _oldRotationS < 0
        ? 1 / 30 * pi
        : _rotationS - _oldRotationS;

    _controller.forward();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));

    _animationM = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _animationS = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _timer = Timer.periodic(const Duration(milliseconds: 500), setTime);
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _size = widget.size;

    return Center(
      child: SizedBox(
        width: _size,
        height: _size,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, child) {
            // print(_controller.value);
            return Stack(
              alignment: Alignment.center,
              children: [
                // Text("$kH:$kM:$kS"),
                /*
                Transform.rotate(
                  // angle:
                  //     _deltaRotationM * _animationM.value / pi + _rotationM,
                  angle: _oldRotationM + _deltaRotationM * _animationM.value,
                  child: ClockArm(
                    size: _size / 30,
                    length: _size * .49,
                    color: widget.minuteColor,
                  ),
                ),
                */
                Transform.rotate(
                  // angle: pi * _deltaRotationS * _animationS.value / pi +
                  //     _rotationS,
                  angle: _oldRotationS + _deltaRotationS * _animationS.value,
                  child: ClockArm(
                    size: _size / 2,
                    length: _size,
                    color: widget.secondColor,
                  ),
                ),
                // if (widget.debug)
                //   Text(
                //     _dateTime.toString(),
                //     style: TextStyle(
                //       fontSize: _size / 20,
                //       color: Colors.black.withOpacity(0.3),
                //     ),
                //   ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ClockArm extends StatelessWidget {
  const ClockArm({
    super.key,
    required this.size,
    required this.length,
    required this.color,
  });

  final double size, length;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(.0, -.5 * (length - size)),
      child: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: size,
              height: length,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size),
                color: Colors.white.withAlpha(0),
              ),
            ),
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size),
                color: color,
                gradient: LinearGradient(
                  begin: const Alignment(-1, -1),
                  end: const Alignment(1, 1),
                  colors: [
                    color
                        .increaseColorHue(-10)
                        .increaseColorSaturation(-.5)
                        .increaseColorLightness(.25),
                    color
                        // .increaseColorHue(10)
                        .increaseColorSaturation(.5)
                    // .increaseColorLightness(-.15),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
