import 'package:abp_tubes_2/pages/home_transaksi.dart';
import 'package:abp_tubes_2/pages/transaksiballroom.dart';
import 'package:abp_tubes_2/pages/transaksikamar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({Key? key}) : super(key: key);

  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  List<Widget> transactionPageList = [
    const HomeTransaksiScreen(),
    const TransaksiKamar(),
    const TransaksiBallroom(),
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: transactionPageList.length,
      itemBuilder: (context, index, realIndex) {
        return transactionPageList.elementAt(index);
      },
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height,
        viewportFraction: 1,
      ),
    );
  }
}
