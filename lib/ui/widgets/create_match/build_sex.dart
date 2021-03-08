import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

class BuildSex extends StatefulWidget {

  final Map<String, bool> gender;

  BuildSex({Key key, this.gender}) : super(key: key);

  @override
  _BuildSexState createState() => _BuildSexState();
}

class _BuildSexState extends State<BuildSex> {
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
                    'Hombre',
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
                  value: widget.gender['men'],
                  inactiveIcon: null,
                  activeIcon: Icon(
                    Icons.sports_soccer,
                    size: 25,
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    print(value);
                    widget.gender['men'] = !widget.gender['men'];
                    if (!widget.gender['men'] && !value) {
                      widget.gender['women'] = true;
                    } else {
                      widget.gender['women'] = false;
                      widget.gender['mix'] = false;
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
                    'Mujer',
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
                  value: widget.gender['women'],
                  inactiveIcon: null,
                  activeIcon: Icon(
                    Icons.sports_soccer,
                    size: 25,
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    widget.gender['women'] = !widget.gender['women'];
                    if (!widget.gender['women'] && !value) {
                      widget.gender['men'] = true;
                    } else {
                      widget.gender['men'] = false;
                      widget.gender['mix'] = false;
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
                    'Mixto',
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
                  value: widget.gender['mix'],
                  inactiveIcon: null,
                  activeIcon: Icon(
                    Icons.sports_soccer,
                    size: 25,
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.gender['mix'] = !widget.gender['mix'];
                      if (!widget.gender['mix'] && !value) {
                        widget.gender['men'] = true;
                      } else {
                        widget.gender['men'] = false;
                        widget.gender['women'] = false;
                      }
                    });
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
