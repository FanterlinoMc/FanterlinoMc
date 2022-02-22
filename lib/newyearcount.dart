import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'countDownText.dart';
import 'happyText.dart';
import 'landscape.dart';

class NewYearsCountdownPage extends StatefulWidget {
  const NewYearsCountdownPage({
    Key? key,
    required this.currentTime,
  }) : super(key: key);

  final DateTime currentTime;

  @override
  _NewYearsCountdownPageState createState() => _NewYearsCountdownPageState();
}

class _NewYearsCountdownPageState extends State<NewYearsCountdownPage>
    with SingleTickerProviderStateMixin {
  final DateTime _newYearDateTime = DateTime.parse('0020-01-01 00:00:00');

  final DateFormat _timeFormat = DateFormat('h:mm:ss a');
  final List<ConfettiController> _fireworksControllers = [];
  final List<DateTime> _fireworksStartTimes = [];
  final List<Alignment> _fireworksAlignments = [];
  late Timer _generateMoreFireworksTimer;

  late AnimationController _mountainFlashController;

  @override
  void initState() {
    super.initState();

    _mountainFlashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void didUpdateWidget(NewYearsCountdownPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentTime.year != widget.currentTime.year) {
      _doFireworks();
    }
  }

  @override
  void dispose() {
    _generateMoreFireworksTimer.cancel();

    _mountainFlashController.dispose();

    for (final controller in _fireworksControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  Future<void> _doFireworks() async {
    // Add a new fireworks controller.
    if (_fireworksControllers.length < 25) {
      final newController =
          ConfettiController(duration: const Duration(milliseconds: 1000))
            ..play();
      _fireworksControllers.add(newController);
      _fireworksStartTimes.add(DateTime.now());

      final random = Random();
      final alignHorizontal = (random.nextDouble() * 2.0) - 1.0;
      final alignVertical = (random.nextDouble() * -0.5) - 0.5;
      _fireworksAlignments.add(Alignment(alignHorizontal, alignVertical));

      _mountainFlashController.reverse(from: 2.0);

      if (mounted) {
        final randomTime = Random().nextInt(2000);
        _generateMoreFireworksTimer =
            Timer(Duration(milliseconds: randomTime), () {
          if (mounted) {
            _doFireworks();
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final secondsUntilNewYear =
        (_newYearDateTime.difference(widget.currentTime).inMilliseconds / 1000)
            .ceil();

    return Stack(
      children: [
        Landscape(
          mode: _buildEnvironmentMode(),
          fireworks: _buildFireworks(),
          flashPercent: _mountainFlashController.value,
          time: _timeFormat.format(widget.currentTime),
          year: '${widget.currentTime.year}',
        ),
        CountdownText(
          secondsToNewYear: secondsUntilNewYear,
        ),
        HappyNewYearText(
          secondsToNewYear: secondsUntilNewYear,
        ),
      ],
    );
  }

  EnvironmentMode _buildEnvironmentMode() {
    final hour = widget.currentTime.hour;
    if (hour >= 6 && hour < 11) {
      return EnvironmentMode.morning;
    } else if (hour >= 11 && hour < 15) {
      return EnvironmentMode.afternoon;
    } else if (hour >= 15 && hour <= 18) {
      return EnvironmentMode.evening;
    } else {
      return EnvironmentMode.night;
    }
  }

  Widget _buildFireworks() {
    // final availableColors = [
    //   Colors.blue,
    //   Colors.red,
    //   Colors.white,
    //   Colors.amber,
    //   Colors.green,
    //   Colors.deepOrange,
    //   Colors.pink,
    // ];
    final colorIndex =
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
        color = colorIndex;
    // final List<Color> ranColor = [
    //   Colors.white,
    //   Colors.blue,
    //   Colors.red,
    //   Colors.brown,
    //   Colors.amber,
    // ];

    // Color randomColors() {
    //   return ranColor[Random().nextInt(2)];
    // }

    final fireworks = <Widget>[];
    for (var i = 0; i < _fireworksControllers.length; ++i) {
      fireworks.add(
        Align(
          alignment: _fireworksAlignments[i],
          child: ConfettiWidget(
            confettiController: _fireworksControllers[i],
            displayTarget: false,
            blastDirectionality: BlastDirectionality.explosive,
            blastDirection: 2 * pi,
            colors: [color],
            minimumSize: const Size(1, 1),
            maximumSize: const Size(5, 5),
            minBlastForce: 0.001,
            maxBlastForce: 0.0011,
            gravity: 0.1,
            particleDrag: 0.3,
            numberOfParticles: 35,
            emissionFrequency: 0.00000001,
            shouldLoop: false,
          ),
        ),
      );
    }

    return Stack(
      children: fireworks,
    );
  }
}
