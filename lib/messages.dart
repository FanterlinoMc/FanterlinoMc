import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'dart:math';

import 'dart:async';

// ignore: camel_case_types
class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

// ignore: camel_case_types
class _MessageState extends State<Message> {
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  late Timer _timer;
  int _start = 5;
  void startTimer() {
    const oneSec = Duration(seconds: 3);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            _controllerCenterRight.play();
            _controllerCenterLeft.play();
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    audioPlayer.open(
      Audio("assets/samurai.mp3"),
      //autoStart: false,
    );
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 5));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 5));
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    return Scaffold(
      // bottomNavigationBar: const SizedBox(
      //   height: 50,
      //   child: BottomAppBar(
      //     shape: CircularNotchedRectangle(),
      //     color: Colors.pinkAccent,
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(
      //     Icons.play_circle_fill_sharp,
      //     color: Colors.white,
      //   ),
      //   backgroundColor: const Color(0xff13195b),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: [
          Image.asset(
            "assets/floor.jpg",
            height: 1000,
            fit: BoxFit.fitHeight,
          ),
          Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: ConfettiWidget(
                  confettiController: _controllerCenterRight,
                  displayTarget: false,
                  blastDirectionality: BlastDirectionality.explosive,
                  blastDirection: pi,

                  minimumSize: const Size(1, 1),
                  maximumSize: const Size(5, 5),

                  gravity: 0.3,
                  particleDrag: 0.3,
                  numberOfParticles: 35,
                  emissionFrequency: 0.6,
                  shouldLoop: false,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink
                  ], // manually specify the colors to be used
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: ConfettiWidget(
                  confettiController: _controllerCenterLeft,
                  blastDirectionality: BlastDirectionality.explosive,
                  blastDirection: pi,
                  minimumSize: const Size(1, 1),
                  maximumSize: const Size(5, 5),
                  gravity: 0.3,
                  particleDrag: 0.3,
                  numberOfParticles: 35,
                  emissionFrequency: 0.6,
                  shouldLoop: false,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 70),
                child: Lottie.asset("assets/partyG.json", height: 270),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 150, top: 400),
                child: Lottie.asset("assets/thisP.json", height: 100),
              ),
              // Lottie.asset("assets/dance.json"),

              Padding(
                padding: const EdgeInsets.only(left: 250, top: 400),
                child: Lottie.asset(
                  "assets/geet.json",
                  height: 150,
                ),
              ),

//                       Align(
              Padding(
                padding: const EdgeInsets.only(top: 450, left: 80),
                child: Lottie.asset(
                  "assets/karam.json",
                  height: 120,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 150, top: 520),
                child: Lottie.asset(
                  "assets/party.json",
                  height: 200,
                ),
              ),
//                         alignment: Alignment.bottomLeft,

//                         child: Lottie.network(
//                             "https://assets4.lottiefiles.com/packages/lf20_DdOuzI.json",
//                             height: 70),
//                       ),
// //
              // Image.asset(
              //   "assets/floor.jpg",
              //   //  height: 650,
              //   fit: BoxFit.fitHeight,
              // )

              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          child: Text("Stop the music",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                              )),
                          onPressed: () {
                            audioPlayer.playOrPause();
                          }),
                      MaterialButton(
                        child: Text(
                          "The Message",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)],
                          ),
                        ),
                        onPressed: () {
                          Get.dialog(AlertDialog(
                            backgroundColor: Colors.blueGrey,
                            title: const Text("Happy Brithday Sandy "),
                            content: SingleChildScrollView(
                              child: Column(
                                children: const [
                                  Text(
                                    '''The best gift you can give to sameone is the gift of love Happy New Year 
                                       ''',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ));
                        },

                        // color: Colors
                        //     .primaries[Random().nextInt(Colors.primaries.length)],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
