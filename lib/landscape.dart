import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'messages.dart';

class Landscape extends StatelessWidget {
  Landscape({
    Key? key,
    required this.mode,
    this.fireworks = const SizedBox(),
    this.flashPercent = 0.0,
    this.time = '',
    this.year = '',
  }) : super(key: key);

  static const switchModeDuration = Duration(milliseconds: 500);
  final EnvironmentMode mode;
  final Widget fireworks;
  final double flashPercent;
  final String time;
  final String year;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildSky(),
        _buildStars(),
        fireworks,
        _buildMountains(),
        _buildMountainsFlash(),
        _buildText(),
        nextScreen(),
      ],
    );
  }

  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  Widget nextScreen() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: MaterialButton(
        child: Text(
          "Next Screen",
          style: TextStyle(
            fontSize: 30,
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          ),
        ),
        onPressed: () {
          Get.to(
            const Message(),
          );
          audioPlayer.stop();
        },
        color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      ),
    );
  }

  Widget _buildSky() {
    return AnimatedSwitcher(
      duration: switchModeDuration,
      child: DecoratedBox(
        key: ValueKey(mode),
        decoration: BoxDecoration(
          gradient: _buildGradient(),
        ),
        child: const SizedBox.expand(),
      ),
    );
  }

  LinearGradient _buildGradient() {
    switch (mode) {
      case EnvironmentMode.morning:
        return morningGradient;
      case EnvironmentMode.afternoon:
        return afternoonGradient;
      case EnvironmentMode.evening:
        return eveningGradient;
      case EnvironmentMode.night:
        return nightGradient;
    }
  }

  Widget _buildStars() {
    return mode == EnvironmentMode.night
        ? Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Image.asset(
              'assets/stars.png',
              fit: BoxFit.cover,
            ),
          )
        : const SizedBox();
  }

  Widget _buildMountains() {
    String mountainsImagePath = '';
    switch (mode) {
      case EnvironmentMode.morning:
        mountainsImagePath = 'assets/mountains_morning.png';
        break;
      case EnvironmentMode.afternoon:
        mountainsImagePath = 'assets/mountains_afternoon.png';
        break;
      case EnvironmentMode.evening:
        mountainsImagePath = 'assets/mountains_evening.png';
        break;
      case EnvironmentMode.night:
        mountainsImagePath = 'assets/mountains_night.png';
        break;
    }

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: AnimatedSwitcher(
        duration: switchModeDuration,
        child: Image.asset(
          mountainsImagePath,
          key: ValueKey(mode),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildMountainsFlash() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Opacity(
        opacity: flashPercent,
        child: Image.asset(
          'assets/mountains_night_flash.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildText() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            year,
            textAlign: TextAlign.center,
            style: TextStyle(
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              fontSize: 100,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            time,
            textAlign: TextAlign.center,
            style: TextStyle(
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Color _buildTextColor() {
    switch (mode) {
      case EnvironmentMode.morning:
        return morningTextColor;
      case EnvironmentMode.afternoon:
        return afternoonTextColor;
      case EnvironmentMode.evening:
        return eveningTextColor;
      case EnvironmentMode.night:
        return nightTextColor;
    }
  }
}

const morningGradient = LinearGradient(
  colors: [
    Color(0xFFFAE81C),
    Colors.white,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const morningTextColor = Color(0xFF797149);

const afternoonGradient = LinearGradient(
  colors: [
    Color(0xFF0D71F9),
    Colors.white,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const afternoonTextColor = Color(0xFF5E576C);

const eveningGradient = LinearGradient(
  colors: [
    Color(0xFFBC3100),
    Color(0xFFE04F08),
    Color(0xFFFF8A00),
    Color(0xFFFFC888),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const eveningTextColor = Color(0xFF832A2A);

const nightGradient = LinearGradient(
  colors: [
    Color(0xFF19142a),
    Color(0xFF3f2b87),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const nightTextColor = Color(0xFF3C148C);

enum EnvironmentMode {
  morning,
  afternoon,
  evening,
  night,
}
