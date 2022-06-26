import 'package:abp_tubes_2/models/room.dart';
import 'package:abp_tubes_2/services/globals.dart';
import 'package:abp_tubes_2/services/roomservices.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailKamar extends StatefulWidget {
  const DetailKamar({
    Key? key,
    required this.room,
    required this.dateFrom,
    required this.dateTo,
  }) : super(key: key);

  final Room room;
  final DateTime dateFrom;
  final DateTime dateTo;

  @override
  State<DetailKamar> createState() => _DetailKamarState();
}

class _DetailKamarState extends State<DetailKamar> {
  bool onLoading = false;
  var numberFormat = NumberFormat("#,##0", "id_ID");
  late int price;
  @override
  void initState() {
    super.initState();
    var difference = widget.dateTo.difference(widget.dateFrom).inDays;
    price = difference * widget.room.price;
  }

  void _orderRoom() {
    setState(() {
      onLoading = true;
    });
    RoomService.orderRoom(
      DateFormat('yyyy-MM-dd').format(widget.dateFrom),
      DateFormat('yyyy-MM-dd').format(widget.dateTo),
      widget.room.id,
    ).then(
      (value) {
        setState(() {
          onLoading = false;
        });

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Pemesanan Berhasil"),
              content: const Text("Silakan Melakukan Pembayaran, Terima Kasih"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        ).then((value) => Navigator.pop(context, true));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.room.roomNumber),
      ),
      body: (onLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.width / 1.5,
                            viewportFraction: 1,
                          ),
                          items: widget.room.photos.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.network(
                                    URL + 'storage/' + i.text,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Rp. ${numberFormat.format(widget.room.price)}",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                ),
                              ),
                              const Text(
                                "/* per net",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.bed_outlined,
                                            size: 30,
                                            color: Colors.deepPurple,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Text(
                                              widget.room.type,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.door_back_door_outlined,
                                            size: 30,
                                            color: Colors.deepPurple,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Text(
                                              widget.room.roomNumber,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(bottom: 20, top: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.stairs_outlined,
                                            size: 30,
                                            color: Colors.deepPurple,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Text(
                                              "Lantai ${widget.room.floor}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.space_dashboard_outlined,
                                            size: 30,
                                            color: Colors.deepPurple,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Text(
                                              "${widget.room.roomArea} m\u{00B2}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Syarat & Ketentuan",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.deepPurple,
                                    width: 2,
                                  ),
                                ),
                                child: const Text(
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: Text(
                      "Rp. ${numberFormat.format(price)} - Pesan",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Konfirmasi"),
                            content: const Text("Apakah anda yakin?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Tidak'),
                              ),
                              TextButton(
                                onPressed: () {
                                  _orderRoom();
                                  Navigator.pop(context);
                                },
                                child: const Text('Ya'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
