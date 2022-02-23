import 'package:flutter/material.dart';

class ClassSA extends StatefulWidget {
  const ClassSA({Key? key}) : super(key: key);

  @override
  State<ClassSA> createState() => _ClassSAState();
}

class _ClassSAState extends State<ClassSA> {
  final TextEditingController hight = TextEditingController();
  final TextEditingController width = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double? h;
    double? w;
    _fanter() {
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(children: [
          TextField(
              keyboardType: TextInputType.number,
              controller: hight,
              onChanged: (val) {
                setState(() {
                  h = double.parse(val);
                });
              }),
          TextField(
            controller: width,

            // onChanged: (val) {
            //   setState(() {
            //     w = double.parse(val);
            //   });
          ),
          TextButton(
            onPressed: () {
              _fanter();
            },
            child: const Text("Works"),
          ),

          AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            color: Colors.brown,
            height: h,
            width: w,
          ),

          // Padding(
          //   padding: const EdgeInsets.only(top: 100.0),
          //   child: Text("Fanerlino"),
          // );
        ]),
      ),
    );
  }
}
