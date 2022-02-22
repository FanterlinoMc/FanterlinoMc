import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main.dart';

class Num extends StatefulWidget {
  Num({Key? key}) : super(key: key);

  @override
  _NumState createState() => _NumState();
}

final TextEditingController passW = TextEditingController();

class _NumState extends State<Num> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String pass = "1101";
    return Scaffold(
        backgroundColor:
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
        body: Stack(children: [
          Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4.0,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: (BorderRadius.circular(0))),
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Column(
                    children: const [
                      Text(
                        "Welcome To the New year App  ",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "All will be revealed at Midnight   ",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                        color: Colors.white, fontSize: size.height * 0.03),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                  ),
                  controller: passW,
                  onChanged: (input) {
                    if (input.contains(pass)) {
                      Get.off(
                        NewYearsCountdownScreen(
                          overrideStartDateTime:
                              DateTime.parse('0019-12-31 23:59:49'),
                          doTick: true,
                        ),
                      );
                      // setState(() {

                      // });
                    } else {
                      const Text("Samething went wrong");
                    }
                  }),
            ],
          ),

          //     TextFormField(
          //         decoration: InputDecoration(
          //             focusedBorder: OutlineInputBorder(
          //                 borderSide: BorderSide(color: Colors.blueAccent))),
          //         controller: passW,
          //         onChanged: (input) {
          //           if (input.contains(pass)) {
          //             Get.to(const Message());
          //             // setState(() {

          //             // });
          //           } else {
          //             const Text("Samething went wrong");
          //           }
          //         }),
          //   ],
          // ),
        ]));
  }
}
