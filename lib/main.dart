import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassmorphic_loona_clock/tools/color.dart';
import 'package:glassmorphic_loona_clock/tools/helper.dart';
import 'package:glassmorphic_loona_clock/widgets/clock_arm.dart';
// import 'package:glassmorphic_loona_clock/widgets/sphere.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    double _size = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    Color globalColor = colorOliviaHye;

    return Scaffold(
      backgroundColor: Colors.black
          .increaseColorLightness(0.1)
          .increaseColorHue(230)
          .increaseColorSaturation(-0.8),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            /*
            Positioned.fill(
              child: ClipRRect(
                child: ImageFiltered(
                  imageFilter:
                      ImageFilter.blur(sigmaX: _size / 25, sigmaY: _size / 25),
                  // ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        globalColor.withOpacity(0.45), BlendMode.color),
                    child: Image.asset(
                      'assets/images/kimlip.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            */

            /*
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(-1, -1),
                    end: const Alignment(1, 1),
                    colors: [
                      globalColor
                          .increaseColorHue(-10)
                          .increaseColorSaturation(-.5)
                          .increaseColorLightness(.45),
                      globalColor
                          // .increaseColorHue(10)
                          .increaseColorSaturation(.5)
                      // .increaseColorLightness(-.15),
                    ],
                  ),
                ),
              ),
            ),
            */
            ClockArmLayer(
              size: _size / 1.7,
              secondColor: globalColor.mix(Colors.white, 0.3),
              minuteColor: globalColor.mix(Colors.black, 0.3),
              debug: true,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(_size),
              child: SizedBox(
                // width: _size * .55,
                // height: _size * .55,
                child: BackdropFilter(
                  filter:
                      ImageFilter.blur(sigmaX: _size / 75, sigmaY: _size / 75),
                  child: Container(
                    width: _size / 2,
                    height: _size / 2,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white10.withAlpha(16),
                          width: _size / 400),
                      borderRadius: BorderRadius.circular(_size),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.transparent,
                          blurRadius: _size / 75,
                          spreadRadius: 0.0,
                        ),
                      ],
                      // color: Colors.white.withOpacity(0.01),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image.asset(
                        //   'assets/images/loona_logo.png',
                        //   height: _size / 3,
                        // ),
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            globalColor.mix(Colors.white, .6).withAlpha(218),
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(
                            'assets/images/loona_logo.png',
                            height: _size / 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // child: Sphere(
        //   size: 500.0,
        //   color: colorHaseul.mix(Colors.grey, .6),
        // ),
      ),
    );
  }
}
