import 'package:app/models/user_hours_available.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';

class ShowUserHoursAvailable extends StatefulWidget {
  final UserHoursAvailable userHoursAvailable;

  const ShowUserHoursAvailable({Key key, this.userHoursAvailable}) : super(key: key);

  @override
  _ShowUserHoursAvailableState createState() => _ShowUserHoursAvailableState();
}

class _ShowUserHoursAvailableState extends State<ShowUserHoursAvailable> {
  bool is08Available = true;
  bool is810Available = true;
  bool is1011Available = true;
  bool is1112Available = true;
  bool is1213Available = true;
  bool is1314Available = true;
  bool is1415Available = true;
  bool is1516Available = true;
  bool is1617Available = true;
  bool is1718Available = true;
  bool is1819Available = true;
  bool is1920Available = true;
  bool is2021Available = true;
  bool is2122Available = true;
  bool is2223Available = true;
  bool is2300Available = true;

  @override
  void initState() {
    this.is08Available = widget.userHoursAvailable.is08Available;
    this.is810Available = widget.userHoursAvailable.is810Available;
    this.is1011Available = widget.userHoursAvailable.is1011Available;
    this.is1112Available = widget.userHoursAvailable.is1112Available;
    this.is1213Available = widget.userHoursAvailable.is1213Available;
    this.is1314Available = widget.userHoursAvailable.is1314Available;
    this.is1415Available = widget.userHoursAvailable.is1415Available;
    this.is1516Available = widget.userHoursAvailable.is1516Available;
    this.is1617Available = widget.userHoursAvailable.is1617Available;
    this.is1718Available = widget.userHoursAvailable.is1718Available;
    this.is1819Available = widget.userHoursAvailable.is1819Available;
    this.is1920Available = widget.userHoursAvailable.is1920Available;
    this.is2021Available = widget.userHoursAvailable.is2021Available;
    this.is2122Available = widget.userHoursAvailable.is2122Available;
    this.is2223Available = widget.userHoursAvailable.is2223Available;
    this.is2300Available = widget.userHoursAvailable.is2300Available;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    Container _buildHourRange(
        bool rangeHour,
        String textRangeHour,
        ) {
      final _width = MediaQuery.of(context).size.width;
      return Container(
        margin: EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: rangeHour
                ? [
              Colors.green[600],
              Colors.green[500],
              Colors.green[500],
              Colors.green[600],
            ]
                : [
              Colors.yellow[700],
              Colors.yellow[600],
              Colors.yellow[600],
              Colors.yellow[700],
            ],
            stops: [0.1, 0.4, 0.7, 0.9],
          ),
          boxShadow: [
            BoxShadow(
              color: rangeHour ? Colors.green[100] : Colors.yellow[100],
              blurRadius: 10.0,
              offset: Offset(0, 8),
            ),
          ],
          color: rangeHour ? Colors.green[400] : Colors.yellow[400],
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        width: _width * .40,
        height: 50.0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textRangeHour,
                style: rangeHour ? kLabelStyle : kLabelStyleBlack,
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      height: _height / 1.2,
      width: _width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 0.0),
            child: Center(
              child: Text(
                'Disponibilidad',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  _buildHourRange(
                    is08Available,
                    '00:00 - 08:00',
                  ),
                  _buildHourRange(
                    is1011Available,
                    '10:00 - 11:00',
                  ),
                  _buildHourRange(
                    is1213Available,
                    '12:00 - 13:00',
                  ),
                  _buildHourRange(
                    is1415Available,
                    '14:00 - 15:00',
                  ),
                  _buildHourRange(
                    is1617Available,
                    '16:00 - 17:00',
                  ),
                  _buildHourRange(
                    is1819Available,
                    '18:00 - 19:00',
                  ),
                  _buildHourRange(
                    is2021Available,
                    '20:00 - 21:00',
                  ),
                  _buildHourRange(
                    is2223Available,
                    '22:00 - 23:00',
                  ),
                ],
              ),
              Column(
                children: [
                  _buildHourRange(
                    is810Available,
                    '08:00 - 10:00',
                  ),
                  _buildHourRange(
                    is1112Available,
                    '11:00 - 12:00',
                  ),
                  _buildHourRange(
                    is1314Available,
                    '13:00 - 14:00',
                  ),
                  _buildHourRange(
                    is1516Available,
                    '15:00 - 16:00',
                  ),
                  _buildHourRange(
                    is1718Available,
                    '17:00 - 18:00',
                  ),
                  _buildHourRange(
                    is1920Available,
                    '19:00 - 20:00',
                  ),
                  _buildHourRange(
                    is2122Available,
                    '21:00 - 22:00',
                  ),
                  _buildHourRange(
                    is2300Available,
                    '23:00 - 00:00',
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
