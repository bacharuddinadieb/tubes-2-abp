import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Home {
  final String id;
  final String nama;
  final String gambar;
  final String deskripsi;
  final String alamat;
  final double latitude;
  final double longitude;

  const Home(
      {required this.id,
      required this.nama,
      required this.gambar,
      required this.deskripsi,
      required this.alamat,
      required this.latitude,
      required this.longitude});

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
        id: json['id'],
        nama: json['nama'],
        gambar: json['gambar'],
        deskripsi: json['deskripsi'],
        alamat: json['alamat'],
        latitude: json['latitude'],
        longitude: json['longitude']);
  }
}

Future<Home> fetchData() async {
  var url = Uri.https('6292ec5a7aa3e6af1a02094f.mockapi.io', '/home');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Home.fromJson(data)).toList()[0];
  } else {
    throw Exception('err!');
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Home> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Home>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Home? data = snapshot.data;
              return Column(
                children: [
                  Image.network(data!.gambar),
                  Container(
                    margin: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data!.nama,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 24),
                        ),
                        Text(
                          data!.alamat,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          child: Text(data!.deskripsi),
                        )
                      ],
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
