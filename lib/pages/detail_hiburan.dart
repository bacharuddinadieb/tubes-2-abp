import 'package:abp_tubes_2/pages/hiburan.dart';
import 'package:flutter/material.dart';

class DetailHiburan extends StatelessWidget {
  const DetailHiburan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hiburan = ModalRoute.of(context)!.settings.arguments as Hiburan;

    return Scaffold(
      appBar: AppBar(
        title: Text(hiburan.nama),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FadeInImage.assetNetwork(
                image: hiburan.gambar,
                placeholder: 'assets/images/Loading_icon.gif',
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hiburan.nama,
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
                    ),
                    Text(
                      'Rp.' + hiburan.harga.toString() + '/hari',
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Text(hiburan.deskripsi),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: const Text('Pesan Sekarang!'),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
