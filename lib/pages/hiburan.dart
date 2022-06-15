import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Hiburan {
  final String id;
  final String nama;
  final int harga;
  final String gambar;
  final String deskripsi;
  final String deskripsiSingkat;

  const Hiburan(
      {required this.id,
      required this.nama,
      required this.harga,
      required this.gambar,
      required this.deskripsi,
      required this.deskripsiSingkat});

  factory Hiburan.fromJson(Map<String, dynamic> json) {
    return Hiburan(
        id: json['id'],
        nama: json['nama'],
        harga: json['harga'],
        gambar: json['gambar'],
        deskripsi: json['deskripsi'],
        deskripsiSingkat: json['deskripsi_singkat']);
  }
}

Future<List<Hiburan>> fetchData() async {
  var url = Uri.https('6292ec5a7aa3e6af1a02094f.mockapi.io', '/hiburan');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Hiburan.fromJson(data)).toList();
  } else {
    throw Exception('err!');
  }
}

class HiburanScreen extends StatefulWidget {
  const HiburanScreen({Key? key}) : super(key: key);

  @override
  State<HiburanScreen> createState() => _HiburanScreenState();
}

class _HiburanScreenState extends State<HiburanScreen> {
  late Future<List<Hiburan>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        child: FutureBuilder<List<Hiburan>>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Hiburan>? data = snapshot.data;
              return ListView.builder(
                  itemCount: data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        margin: const EdgeInsets.only(
                            left: 8, right: 8, top: 4, bottom: 4),
                        child: ListTile(
                            title: Container(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data![index].nama,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 24),
                                  ),
                                  Text(
                                    'Rp. ' +
                                        data![index].harga.toString() +
                                        ' /orang',
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 12),
                                    child: Image.network(data[index].gambar),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 12),
                                    child: Text(data[index].deskripsiSingkat),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {}));
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
