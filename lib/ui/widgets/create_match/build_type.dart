import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

class BuildType extends StatefulWidget {

  final Map<String, bool> matchType;

  BuildType({Key key, this.matchType}) : super(key: key);

  @override
  _BuildTypeState createState() => _BuildTypeState();
}

class _BuildTypeState extends State<BuildType> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Container(
      height: _height / 1.4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Futbol 5',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                GFCheckbox(
                  size: 35,
                  activeBgColor: Colors.green[400],
                  inactiveBorderColor: Colors.green[700],
                  activeBorderColor: Colors.green[700],
                  type: GFCheckboxType.circle,
                  value: widget.matchType['f5'],
                  inactiveIcon: null,
                  activeIcon: Icon(
                    Icons.sports_soccer,
                    size: 25,
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    widget.matchType['f5'] = !widget.matchType['f5'];
                    if (widget.matchType['f5']) {
                      widget.matchType['f7'] = false;
                      widget.matchType['f9'] = false;
                      widget.matchType['f11'] = false;
                    }
                    if (!widget.matchType['f5'] && !value) {
                      widget.matchType['f5'] = true;
                    }

                    setState(() {});
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Futbol 7',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                GFCheckbox(
                  size: 35,
                  activeBgColor: Colors.green[400],
                  inactiveBorderColor: Colors.green[700],
                  activeBorderColor: Colors.green[700],
                  type: GFCheckboxType.circle,
                  value: widget.matchType['f7'],
                  inactiveIcon: null,
                  activeIcon: Icon(
                    Icons.sports_soccer,
                    size: 25,
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    widget.matchType['f7'] = !widget.matchType['f7'];
                    if (widget.matchType['f7']) {
                      widget.matchType['f5'] = false;
                      widget.matchType['f9'] = false;
                      widget.matchType['f11'] = false;
                    }
                    if (!widget.matchType['f7'] && !value) {
                      widget.matchType['f5'] = true;
                    }

                    setState(() {});
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Futbol 9',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                GFCheckbox(
                  size: 35,
                  activeBgColor: Colors.green[400],
                  inactiveBorderColor: Colors.green[700],
                  activeBorderColor: Colors.green[700],
                  type: GFCheckboxType.circle,
                  value: widget.matchType['f9'],
                  inactiveIcon: null,
                  activeIcon: Icon(
                    Icons.sports_soccer,
                    size: 25,
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    widget.matchType['f9'] = !widget.matchType['f9'];
                    if (widget.matchType['f9']) {
                      widget.matchType['f5'] = false;
                      widget.matchType['f7'] = false;
                      widget.matchType['f11'] = false;
                    }
                    if (!widget.matchType['f9'] && !value) {
                      widget.matchType['f5'] = true;
                    }
                    setState(() {});
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Futbol 11',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                GFCheckbox(
                  size: 35,
                  activeBgColor: Colors.green[400],
                  inactiveBorderColor: Colors.green[700],
                  activeBorderColor: Colors.green[700],
                  type: GFCheckboxType.circle,
                  value: widget.matchType['f11'],
                  inactiveIcon: null,
                  activeIcon: Icon(
                    Icons.sports_soccer,
                    size: 25,
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    widget.matchType['f11'] = !widget.matchType['f11'];
                    if (widget.matchType['f11']) {
                      widget.matchType['f5'] = false;
                      widget.matchType['f7'] = false;
                      widget.matchType['f9'] = false;
                    }
                    if (!widget.matchType['f11'] && !value) {
                      widget.matchType['f5'] = true;
                    }
                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
