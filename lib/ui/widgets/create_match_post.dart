import 'package:flutter/material.dart';

class CreateMatchPost extends StatefulWidget {
  @override
  _CreateMatchPostState createState() => _CreateMatchPostState();
}

class _CreateMatchPostState extends State<CreateMatchPost> {
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
