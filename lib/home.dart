import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:temp_knob/knob_painter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ValueNotifier<int> temperature = ValueNotifier(3);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  width: size.width * 0.6,
                  height: size.width * 0.6,
                  child: ValueListenableBuilder(
                      valueListenable: temperature,
                      builder: (context, val, _) {
                        return CustomPaint(
                          painter: KnobPainter(
                              value: val, startValue: 16, endValue: 24),
                        );
                      }),
                ),
              ),
            ),
            Container(
              width: size.width,
              height: size.width * 0.5,
              color: Colors.white10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: buttonDecortion(),
                    child: IconButton(
                      iconSize: size.width * 0.2,
                      onPressed: () {
                        HapticFeedback.heavyImpact();
                        if (temperature.value > 0) {
                          temperature.value--;
                        }
                      },
                      icon: const Icon(Icons.remove, color: Colors.black),
                    ),
                  ),
                  Container(
                    decoration: buttonDecortion(),
                    child: IconButton(
                      iconSize: size.width * 0.2,
                      onPressed: () {
                        HapticFeedback.heavyImpact();
                        if (temperature.value < 8) {
                          temperature.value++;
                        }
                      },
                      icon: const Icon(Icons.add, color: Colors.black),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

BoxDecoration buttonDecortion() {
  return const BoxDecoration(shape: BoxShape.circle, color: Colors.white);
}
