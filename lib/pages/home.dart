import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  static LatLng lokasi = const LatLng(-6.975575564736307, 107.63055772782457);
  static CameraPosition cameraPosition = CameraPosition(
    target: lokasi,
    zoom: 18,
  );

  Set<Marker> markerGedung() {
    return {
      Marker(
          markerId: const MarkerId('gedung'),
          infoWindow: const InfoWindow(title: 'Gedung Marriot'),
          position: lokasi),
    };
  }

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
              Home data = snapshot.data ??
                  const Home(
                      id: '',
                      alamat: '',
                      deskripsi: '',
                      gambar: '',
                      latitude: 0,
                      longitude: 0,
                      nama: '');
              return SingleChildScrollView(
                child: Column(
                  children: [
                    FadeInImage.assetNetwork(
                      image: data.gambar,
                      placeholder: 'assets/images/Loading_icon.gif',
                    ),
                    Container(
                      margin: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.nama,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 24),
                          ),
                          Text(
                            data.alamat,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            child: Text(data.deskripsi),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            child: const Text(
                              'Lokasi',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: GoogleMap(
                              initialCameraPosition: cameraPosition,
                              mapType: MapType.normal,
                              markers: markerGedung(),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
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
