import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  dynamic sliderValue;

  CustomSlider({Key key, this.sliderValue}) : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.green[700],
        inactiveTrackColor: Colors.green[100],
        trackShape: RoundedRectSliderTrackShape(),
        trackHeight: 4.0,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
        thumbColor: Colors.green,
        overlayColor: Colors.green.withAlpha(32),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
        tickMarkShape: RoundSliderTickMarkShape(),
        activeTickMarkColor: Colors.green[700],
        inactiveTickMarkColor: Colors.green[100],
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: Colors.green,
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      child: Slider(
        value: widget.sliderValue,
        min: 0,
        max: 100,
        divisions: 10,
        label: '${widget.sliderValue}',
        onChanged: (value) {
          setState(
            () {
              widget.sliderValue = value;
            },
          );
        },
      ),
    );
  }
}
