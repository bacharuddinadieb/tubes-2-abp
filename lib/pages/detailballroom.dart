import 'package:flutter/material.dart';

class DetailBallroom extends StatefulWidget {
  const DetailBallroom({Key? key}) : super(key: key);

  @override
  State<DetailBallroom> createState() => _DetailBallroomState();
}

class _DetailBallroomState extends State<DetailBallroom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Detail Ballroom"),
      ),
      body: Center(
        child: Text('Detail Ballroom'),
      ),
    );
  }
}
