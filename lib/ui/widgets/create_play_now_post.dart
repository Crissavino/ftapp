import 'dart:io';

import 'package:app/utils/date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatePlayNowPost extends StatefulWidget {
  @override
  _CreatePlayNowPostState createState() => _CreatePlayNowPostState();
}

class _CreatePlayNowPostState extends State<CreatePlayNowPost> {
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return Container(
      height: _height / 1.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text('Cuando quieres jugar?'),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.info_outline,
                            color: Colors.blue,
                            size: 20.0,
                          ),
                          onPressed: () {
                            print('Selecciona el/los dias que quieres jugar');
                            print(this._selectedDate);
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 100.0,
                    height: 30.0,
                    child: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        this._selectedDate = await openDatePicker(context);
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
