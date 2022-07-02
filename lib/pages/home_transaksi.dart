import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Transaksi {
  final String id;
  final String createdAt;
  final String nama;
  final int harga;
  final String tanggalMasuk;
  final String tanggalKeluar;
  final String gambar;
  final String tipe;
  final String jenis;

  const Transaksi({
    required this.id,
    required this.createdAt,
    required this.nama,
    required this.harga,
    required this.tanggalMasuk,
    required this.tanggalKeluar,
    required this.gambar,
    required this.tipe,
    required this.jenis,
  });

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    return Transaksi(
      id: json['id'],
      createdAt: json['created_at'],
      nama: json['nama'],
      harga: json['harga'],
      tanggalMasuk: json['tanggal_masuk'],
      tanggalKeluar: json['tanggal_keluar'],
      gambar: json['gambar'],
      tipe: json['tipe'],
      jenis: json['jenis'],
    );
  }
}

Future<List<Transaksi>> fetchData() async {
  var url = Uri.https('6292ec5a7aa3e6af1a02094f.mockapi.io', '/transaksi');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Transaksi.fromJson(data)).toList();
  } else {
    throw Exception('err!');
  }
}

String getSelisihTanggal(DateTime tanggalAwal, DateTime tanggalAkhir) {
  int selisihTanggal = tanggalAkhir.difference(tanggalAwal).inDays;
  selisihTanggal = selisihTanggal + 1;
  return selisihTanggal.toString();
}

String getTanggal(DateTime tanggalAwal, DateTime tanggalAkhir) {
  String tglawal = DateFormat('dd MMMM').format(tanggalAwal);
  String tglakhir = DateFormat('dd MMMM').format(tanggalAkhir);
  int selisihTanggal = tanggalAkhir.difference(tanggalAwal).inDays;
  return selisihTanggal != 0 ? tglawal + ' - ' + tglakhir : tglawal;
}

class HomeTransaksiScreen extends StatefulWidget {
  const HomeTransaksiScreen({Key? key}) : super(key: key);

  @override
  State<HomeTransaksiScreen> createState() => _HomeTransaksiScreenState();
}

class _HomeTransaksiScreenState extends State<HomeTransaksiScreen> {
  late Future<List<Transaksi>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        child: FutureBuilder<List<Transaksi>>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Transaksi> data = snapshot.data ?? [];
              return ListView.builder(
                  itemCount: data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        margin: const EdgeInsets.only(
                            left: 8, right: 8, top: 4, bottom: 4),
                        child: ListTile(
                          title: Container(
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 8, left: 0),
                              child: Row(
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      margin: EdgeInsets.only(right: 12),
                                      child: FadeInImage.assetNetwork(
                                        image: data[index].gambar,
                                        placeholder:
                                            'assets/images/Loading_icon.gif',
                                      )),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 4),
                                        child: Text(
                                          data[index].nama,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 24),
                                        ),
                                      ),
                                      Text(
                                        'Rp. ' +
                                            data[index].harga.toString() +
                                            ' @ ' +
                                            getSelisihTanggal(
                                                DateTime.parse(
                                                    data[index].tanggalMasuk),
                                                DateTime.parse(data[index]
                                                    .tanggalKeluar)) +
                                            ' malam',
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        getTanggal(
                                            DateTime.parse(
                                                data[index].tanggalMasuk),
                                            DateTime.parse(
                                                data[index].tanggalKeluar)),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              scrollable: true,
                              title: Text('Datail Transaksi'),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Jenis: ' + data[index].tipe),
                                  Text('Tipe: ' + data[index].tipe),
                                  Text('Durasi: ' +
                                      getTanggal(
                                          DateTime.parse(
                                              data[index].tanggalMasuk),
                                          DateTime.parse(
                                              data[index].tanggalKeluar)) +
                                      '(' +
                                      getSelisihTanggal(
                                          DateTime.parse(
                                              data[index].tanggalMasuk),
                                          DateTime.parse(
                                              data[index].tanggalKeluar)) +
                                      ' malam' +
                                      ')'),
                                  Text('Rp. ' + data[index].harga.toString())
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Tutup'),
                                ),
                              ],
                            ),
                          ),
                        ));
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
