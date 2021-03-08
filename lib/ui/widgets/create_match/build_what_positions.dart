import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/checkbox_list_tile/gf_checkbox_list_tile.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

class BuildWhatPositions extends StatefulWidget {

  final Map<String, int> whatPositions;

  BuildWhatPositions({Key key, this.whatPositions}) : super(key: key);

  @override
  _BuildWhatPositionsState createState() => _BuildWhatPositionsState();
}

class _BuildWhatPositionsState extends State<BuildWhatPositions> {

  TextEditingController _goalKeeperController = TextEditingController();
  TextEditingController _defenseController = TextEditingController();
  TextEditingController _midfielderController = TextEditingController();
  TextEditingController _forwardController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    this._goalKeeperController.text = widget.whatPositions['goalKeeper'].toString();
    this._defenseController.text = widget.whatPositions['defense'].toString();
    this._midfielderController.text = widget.whatPositions['midfielder'].toString();
    this._forwardController.text = widget.whatPositions['forward'].toString();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    this._goalKeeperController.dispose();
    this._defenseController.dispose();
    this._midfielderController.dispose();
    this._forwardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        height: _height / 1.4,
        width: _width,
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
              GFListTile(
                padding: EdgeInsets.all(0),
                title: Center(
                  child: Text(
                    'Arquero',
                    style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                avatar: GFAvatar(
                  backgroundImage: AssetImage(
                      'assets/icons/primary/007-goalkeeper.png'),
                  size: 45.0,
                ),
                icon: Container(
                  alignment: Alignment.centerLeft,
                  width: _width * .15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  height: 60.0,
                  child: Focus(
                    onFocusChange: (focus) {
                      if (!focus && this._goalKeeperController.text.isEmpty) {
                        this._goalKeeperController.text = '0';
                      }
                    },
                    child: TextFormField(
                      controller: this._goalKeeperController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^[0-1]?[0-9]$')),
                      ],
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 14.0),
                        hintStyle: kHintTextStyle,
                      ),
                      onChanged: (val) {
                        if (val.isEmpty) {
                          setState(() => widget.whatPositions['goalKeeper'] = 0);
                        } else {
                          setState(() => widget.whatPositions['goalKeeper'] = int.parse(val));
                        }
                      },
                    ),
                  ),
                ),
              ),
              GFListTile(
                padding: EdgeInsets.all(0),
                title: Center(
                  child: Text(
                    'Defensor',
                    style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                avatar: GFAvatar(
                  backgroundImage:
                  AssetImage('assets/icons/primary/005-pads.png'),
                  size: 45.0,
                ),
                icon: Container(
                  alignment: Alignment.centerLeft,
                  width: _width * .15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  height: 60.0,
                  child: Focus(
                    onFocusChange: (focus) {
                      if (!focus && this._defenseController.text.isEmpty) {
                        this._defenseController.text = '0';
                      }
                    },
                    child: TextFormField(
                      controller: this._defenseController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^[0-1]?[0-9]$')),
                      ],
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 14.0),
                        hintStyle: kHintTextStyle,
                      ),
                      onChanged: (val) {
                        if (val.isEmpty) {
                          setState(() => widget.whatPositions['defense'] = 0);
                        } else {
                          setState(() => widget.whatPositions['defense'] = int.parse(val));
                        }
                      },
                    ),
                  ),
                ),
              ),
              GFListTile(
                padding: EdgeInsets.all(0),
                title: Center(
                  child: Text(
                    'Mediocampista',
                    style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                avatar: GFAvatar(
                  backgroundImage: AssetImage(
                      'assets/icons/primary/006-footwear.png'),
                  size: 45.0,
                ),
                icon: Container(
                  alignment: Alignment.centerLeft,
                  width: _width * .15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  height: 60.0,
                  child: Focus(
                    onFocusChange: (focus) {
                      if (!focus && this._midfielderController.text.isEmpty) {
                        this._midfielderController.text = '0';
                      }
                    },
                    child: TextFormField(
                      controller: this._midfielderController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^[0-1]?[0-9]$')),
                      ],
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 14.0),
                        hintStyle: kHintTextStyle,
                      ),
                      onChanged: (val) {
                        if (val.isEmpty) {
                          setState(() => widget.whatPositions['midfielder'] = 0);
                        } else {
                          setState(() => widget.whatPositions['midfielder'] = int.parse(val));
                        }
                      },
                    ),
                  ),
                ),
              ),
              GFListTile(
                padding: EdgeInsets.all(0),
                title: Center(
                  child: Text(
                    'Delantero',
                    style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                avatar: GFAvatar(
                  backgroundImage: AssetImage(
                      'assets/icons/primary/013-football-1.png'),
                  size: 45.0,
                ),
                icon: Container(
                  alignment: Alignment.centerLeft,
                  width: _width * .15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  height: 60.0,
                  child: Focus(
                    onFocusChange: (focus) {
                      if (!focus && this._forwardController.text.isEmpty) {
                        this._defenseController.text = '0';
                      }
                    },
                    child: TextFormField(
                      controller: this._forwardController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^[0-1]?[0-9]$')),
                      ],
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 14.0),
                        hintStyle: kHintTextStyle,
                      ),
                      onChanged: (val) {
                        if (val.isEmpty) {
                          setState(() => widget.whatPositions['forward'] = 0);
                        } else {
                          setState(() => widget.whatPositions['forward'] = int.parse(val));
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     GFCheckboxListTile(
          //       title: Center(
          //         child: Text(
          //           'Arquero',
          //           style: TextStyle(
          //               fontSize: 18.0, fontWeight: FontWeight.bold),
          //         ),
          //       ),
          //       avatar: GFAvatar(
          //         backgroundImage: AssetImage(
          //             'assets/icons/primary/007-goalkeeper.png'),
          //         size: 45.0,
          //       ),
          //       size: 35,
          //       activeBgColor: Colors.green[400],
          //       inactiveBorderColor: Colors.green[700],
          //       activeBorderColor: Colors.green[700],
          //       type: GFCheckboxType.circle,
          //       padding: EdgeInsets.all(0),
          //       activeIcon: Icon(
          //         Icons.sports_soccer,
          //         size: 25,
          //         color: Colors.white,
          //       ),
          //       onChanged: (value) {
          //         widget.whatPositions['goalKeeper'] = !widget.whatPositions['goalKeeper'];
          //         bool isAllFalse = !widget.whatPositions['defense'] && !widget.whatPositions['midfielder'] && !widget.whatPositions['forward'];
          //         if (isAllFalse && !value) {
          //           widget.whatPositions['goalKeeper'] = true;
          //         }
          //
          //         setState(() {});
          //       },
          //       value: widget.whatPositions['goalKeeper'],
          //       inactiveIcon: null,
          //     ),
          //     GFCheckboxListTile(
          //       title: Center(
          //         child: Text(
          //           'Defensor',
          //           style: TextStyle(
          //               fontSize: 18.0, fontWeight: FontWeight.bold),
          //         ),
          //       ),
          //       avatar: GFAvatar(
          //         backgroundImage:
          //         AssetImage('assets/icons/primary/005-pads.png'),
          //         size: 45.0,
          //       ),
          //       size: 35,
          //       activeBgColor: Colors.green[400],
          //       inactiveBorderColor: Colors.green[700],
          //       activeBorderColor: Colors.green[700],
          //       type: GFCheckboxType.circle,
          //       padding: EdgeInsets.all(0),
          //       activeIcon: Icon(
          //         Icons.sports_soccer,
          //         size: 25,
          //         color: Colors.white,
          //       ),
          //       onChanged: (value) {
          //         widget.whatPositions['defense'] = !widget.whatPositions['defense'];
          //         bool isAllFalse = !widget.whatPositions['goalKeeper'] && !widget.whatPositions['midfielder'] && !widget.whatPositions['forward'];
          //         if (isAllFalse && !value) {
          //           widget.whatPositions['defense'] = true;
          //         }
          //
          //         setState(() {});
          //       },
          //       value: widget.whatPositions['defense'],
          //       inactiveIcon: null,
          //     ),
          //     GFCheckboxListTile(
          //       title: Center(
          //         child: Text(
          //           'Mediocampista',
          //           style: TextStyle(
          //               fontSize: 18.0, fontWeight: FontWeight.bold),
          //         ),
          //       ),
          //       avatar: GFAvatar(
          //         backgroundImage: AssetImage(
          //             'assets/icons/primary/006-footwear.png'),
          //         size: 45.0,
          //       ),
          //       size: 35,
          //       activeBgColor: Colors.green[400],
          //       inactiveBorderColor: Colors.green[700],
          //       activeBorderColor: Colors.green[700],
          //       type: GFCheckboxType.circle,
          //       padding: EdgeInsets.all(0),
          //       activeIcon: Icon(
          //         Icons.sports_soccer,
          //         size: 25,
          //         color: Colors.white,
          //       ),
          //       onChanged: (value) {
          //         widget.whatPositions['midfielder'] = !widget.whatPositions['midfielder'];
          //         bool isAllFalse = !widget.whatPositions['goalKeeper'] && !widget.whatPositions['defense'] && !widget.whatPositions['forward'];
          //         if (isAllFalse && !value) {
          //           widget.whatPositions['midfielder'] = true;
          //         }
          //
          //         setState(() {});
          //       },
          //       value: widget.whatPositions['midfielder'],
          //       inactiveIcon: null,
          //     ),
          //     GFCheckboxListTile(
          //       title: Center(
          //         child: Text(
          //           'Delantero',
          //           style: TextStyle(
          //               fontSize: 18.0, fontWeight: FontWeight.bold),
          //         ),
          //       ),
          //       avatar: GFAvatar(
          //         backgroundImage: AssetImage(
          //             'assets/icons/primary/013-football-1.png'),
          //         size: 45.0,
          //       ),
          //       size: 35,
          //       activeBgColor: Colors.green[400],
          //       inactiveBorderColor: Colors.green[700],
          //       activeBorderColor: Colors.green[700],
          //       type: GFCheckboxType.circle,
          //       padding: EdgeInsets.all(0),
          //       activeIcon: Icon(
          //         Icons.sports_soccer,
          //         size: 25,
          //         color: Colors.white,
          //       ),
          //       onChanged: (value) {
          //         widget.whatPositions['forward'] = !widget.whatPositions['forward'];
          //         bool isAllFalse = !widget.whatPositions['goalKeeper'] && !widget.whatPositions['defense'] && !widget.whatPositions['midfielder'];
          //         if (isAllFalse && !value) {
          //           widget.whatPositions['forward'] = true;
          //         }
          //
          //         setState(() {});
          //       },
          //       value: widget.whatPositions['forward'],
          //       inactiveIcon: null,
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
