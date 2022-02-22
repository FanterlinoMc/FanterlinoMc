import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class HappyNewYearText extends StatefulWidget {
  const HappyNewYearText({
    Key? key,
    this.secondsToNewYear,
  }) : super(key: key);

  final secondsToNewYear;

  @override
  _HappyNewYearTextState createState() => _HappyNewYearTextState();
}

class _HappyNewYearTextState extends State<HappyNewYearText>
    with SingleTickerProviderStateMixin {
  late AnimationController _showHappyNewYearController;
  final Interval _opacity = const Interval(0.0, 0.4);
  final Interval _scale = const Interval(0.0, 0.5, curve: Curves.elasticOut);
  late int _previousSecondsToNewYear;

  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  @override
  void initState() {
    super.initState();

    _showHappyNewYearController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(() {
        setState(() {});
      });

    _previousSecondsToNewYear = widget.secondsToNewYear;
    if (_shouldDisplayHappyNewYears()) {
      _showHappyNewYearController.forward();
    }

    // audioPlayer.open(Audio('assets/Happy.mp3'),
    //     autoStart: false, showNotification: true);

    audioPlayer.open(Audio('assets/working.mp3'),
        autoStart: false, showNotification: true);
  }

  @override
  void didUpdateWidget(HappyNewYearText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.secondsToNewYear != _previousSecondsToNewYear) {
      _previousSecondsToNewYear = widget.secondsToNewYear;
      if (_shouldDisplayHappyNewYears()) {
        _showHappyNewYearController.forward();
      }
    }
    if (_showHappyNewYearController.isAnimating) {
      audioPlayer.play();
    }
  }

  @override
  void dispose() {
    _showHappyNewYearController.dispose();

    super.dispose();
  }

  bool _shouldDisplayHappyNewYears() =>
      widget.secondsToNewYear != null &&
      widget.secondsToNewYear <= 0 &&
      widget.secondsToNewYear > -40;

  // Widget nextScreen(BuildContext context) {
  //   return Positioned(
  //     left: 0,
  //     right: 0,
  //     bottom: 0,
  //     child: MaterialButton(
  //       child: Text(
  //         "Next Screen",
  //         style: TextStyle(
  //           fontSize: 30,
  //           color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
  //         ),
  //       ),
  //       onPressed: () {
  //         audioPlayer.stop();
  //         Get.to(
  //           const Message(),
  //         );
  //       },
  //       color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: _shouldDisplayHappyNewYears()
          ? Align(
              alignment: const Alignment(0.0, -0.35),
              child: Transform.scale(
                scale: _scale.transform(_showHappyNewYearController.value),
                child: Opacity(
                  opacity:
                      _opacity.transform(_showHappyNewYearController.value),
                  child: Text(
                    'HAPPY\nBirthday\nSandy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      height: 0.9,
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
