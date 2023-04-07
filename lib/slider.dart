import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:ranger_slider/custom_range_shape.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.dark(
//       ),
//       debugShowCheckedModeBanner: false,
//       home: MyHomePage(),
//     );
//   }
// }

class MyHomePage1 extends StatefulWidget {

  @override
  _MyHomePage1State createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {
  RangeValues values = RangeValues(1, 100);
  RangeLabels labels =RangeLabels('1', "100");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text( 'Flutter RangeSlider Demo'),
      ),
      body: SliderTheme(
         data: SliderThemeData(
        //   rangeThumbShape: CustomRangeShape(),
        //    trackHeight: 10,
        ),
        child: Center(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.all(
                Radius.circular(20),
              ),
              // gradient: RadialGradient(
              //   colors: <Color>[
              //     Colors.orangeAccent,
              //      Color.lerp(Colors.cyan, Colors.black,.01)
              //   ],
              // ),
            ),
            child: RangeSlider(
                // divisions: ,
                activeColor: Colors.black,
                inactiveColor: Colors.black,
                min: 1,
                max: 100,
                values: values,
                labels: labels,
                onChanged: (value){
                  print("START: ${value.start}, End: ${value.end}");

                  setState(() {
                    values =value;
                    labels =RangeLabels("${value.start.toInt().toString()}", "${value.end.toInt().toString()}");
                  });
                }
            ),
          ),
        ),
      ),
    );
  }
}