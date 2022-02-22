
import 'package:flutter/material.dart';
import 'package:fun/play.dart';
import 'package:get/get.dart';

import 'newyearcount.dart';
import 'timeLapse.dart';

void main() {
  runApp(const Sandy());
}

class Sandy extends StatelessWidget {
  const Sandy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Happy Birthdey !',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Num(),
      // NewYearsCountdownScreen(
      //   overrideStartDateTime: DateTime.parse('0019-12-31 23:59:49'),
      //   doTick: true,
      // ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NewYearsCountdownScreen extends StatelessWidget {
  const NewYearsCountdownScreen({
    Key? key,
    required this.overrideStartDateTime,
    required this.doTick,
  }) : super(key: key);

  final DateTime overrideStartDateTime;
  final bool doTick;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TimeLapse(
        overrideStartDateTime: overrideStartDateTime,
        doTick: doTick,
        dateTimeBuilder: (DateTime currentTime) {
          return NewYearsCountdownPage(
            currentTime: currentTime,
          );
        },
      ),
    );
  }
}

