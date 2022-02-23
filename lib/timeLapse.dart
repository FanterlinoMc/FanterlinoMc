// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TimeLapse extends StatefulWidget {
  const TimeLapse({
    Key? key,
    required this.overrideStartDateTime,
    required this.doTick,
    required this.dateTimeBuilder,
  }) : super(key: key);

  final DateTime overrideStartDateTime;
  final bool doTick;
  final Widget Function(DateTime) dateTimeBuilder;

  @override
  _TimeLapseState createState() => _TimeLapseState();
}

class _TimeLapseState extends State<TimeLapse>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  late DateTime _initialTime;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();

    // ignore: unnecessary_null_comparison
    if (widget.overrideStartDateTime != null) {
      _initialTime = widget.overrideStartDateTime;
    } else {
      _initialTime = DateTime.now();
    }
    _currentTime = _initialTime;

    _ticker = createTicker(_onTick);
    if (widget.doTick) {
      _ticker.start();
    }
  }

  @override
  void didUpdateWidget(TimeLapse oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.overrideStartDateTime != oldWidget.overrideStartDateTime) {
      // ignore: unnecessary_null_comparison
      if (widget.overrideStartDateTime == null) {
        _initialTime = DateTime.now();
      } else {
        _initialTime = widget.overrideStartDateTime;
      }
      _currentTime = _initialTime;

      _ticker.stop();
      if (widget.doTick) {
        _ticker.start();
      }
    } else if (widget.doTick != oldWidget.doTick) {
      if (widget.doTick) {
        _ticker.start();
      } else {
        _ticker.stop();
      }
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsedTime) {
    _initialTime;

    final newTime = _initialTime.add(elapsedTime);
    if (newTime.second != _currentTime.second) {
      setState(() {
        _currentTime = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.dateTimeBuilder(_currentTime);
  }
}
