import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:torch_controller/torch_controller.dart';

import '../CustomBannerAd.dart';

class FlashLight extends StatefulWidget {
  const FlashLight({Key? key}) : super(key: key);

  @override
  State<FlashLight> createState() => _FlashLightState();
}

class _FlashLightState extends State<FlashLight> with TickerProviderStateMixin{
  late AnimationController _animatedcontroller;
  Color color = Colors.black45;
  double fontSize = 20;
  bool isClicked = true;
  final _controller = TorchController();

  final DecorationTween decorationTween = DecorationTween(
      begin: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
                color: Colors.red,
                spreadRadius: 5,
                blurRadius: 20,
                offset: Offset(0, 0))
          ],
          border: Border.all(color: Colors.yellow)),
      end: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.yellow),
          boxShadow: const [
            BoxShadow(
                color: Colors.green,
                spreadRadius: 30,
                blurRadius: 15,
                offset: Offset(0, 0))
          ]));

  @override
  void initState() {
    super.initState();

    _animatedcontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (isClicked) {
                _animatedcontroller.forward();
                fontSize = 25;
                color = Colors.green;
                HapticFeedback.lightImpact();
              } else {
                _animatedcontroller.reverse();
                fontSize = 20;
                color = Colors.red;
                HapticFeedback.lightImpact();
              }
              isClicked = !isClicked;
              _controller.toggle();
              setState(() {});
            },
            child: Center(
              child: DecoratedBoxTransition(
                position: DecorationPosition.background,
                decoration: decorationTween.animate(_animatedcontroller),
                child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Center(
                        child: Icon(
                          Icons.lightbulb,
                          color: isClicked ? Colors.red : Colors.green,
                          size: 60,
                        ))),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomBannerAd(),
          ),
        ],
      ),
    );
  }
}
