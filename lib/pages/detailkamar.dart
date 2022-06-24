import 'package:flutter/material.dart';

class DetailKamar extends StatefulWidget {
  const DetailKamar({Key? key}) : super(key: key);

  @override
  State<DetailKamar> createState() => _DetailKamarState();
}

class _DetailKamarState extends State<DetailKamar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Detail Kamar"),
      ),
      body: Center(
        child: Text('Detail Kamar'),
      ),
    );
  }
}
