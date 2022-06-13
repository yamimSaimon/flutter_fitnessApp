import 'package:fitness_app/model/model.dart';
import 'package:fitness_app/third_page.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Secondpage extends StatefulWidget {
  Secondpage({Key? key, this.excerciesModel}) : super(key: key);
  ExcerciesModel? excerciesModel;

  @override
  State<Secondpage> createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            "${widget.excerciesModel!.thumbnail}",
            width: double.infinity,
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Positioned(
            bottom: 20,
            right: 0,
            left: 0,
            child: Column(
              children: [
                SleekCircularSlider(
                  innerWidget: (value) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text("${second.toStringAsFixed(0)} S"),
                    );
                  },
                  appearance: CircularSliderAppearance(
                      customWidths: CustomSliderWidths(progressBarWidth: 10)),
                  min: 3,
                  max: 28,
                  initialValue: second,
                  onChange: (value) {
                    setState(() {
                      second = value;
                    });
                  },
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ThirdPage(
                              excerciesModel: widget.excerciesModel,
                              second: second.toInt(),
                            )));
                  },
                  color: Colors.orange,
                  child: Text("Next"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  double second = 3;
}
