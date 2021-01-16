import 'package:flutter/material.dart';

class CreatePlayNowPost extends StatefulWidget {
  @override
  _CreatePlayNowPostState createState() => _CreatePlayNowPostState();
}

class _CreatePlayNowPostState extends State<CreatePlayNowPost> {
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
        child: Column(
          children: [
            Text('Prueba'),
          ],
        ),
      ),
    );
  }
}
