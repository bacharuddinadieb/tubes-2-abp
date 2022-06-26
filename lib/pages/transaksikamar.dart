import 'package:abp_tubes_2/models/roomtransaction.dart';
import 'package:abp_tubes_2/services/globals.dart';
import 'package:abp_tubes_2/services/roomservices.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransaksiKamar extends StatefulWidget {
  const TransaksiKamar({Key? key}) : super(key: key);

  @override
  State<TransaksiKamar> createState() => _TransaksiKamarState();
}

class _TransaksiKamarState extends State<TransaksiKamar> {
  final String baseUrl = URL;
  var numberFormat = NumberFormat("#,##0", "id_ID");
  bool onLoading = true;
  List<RoomTransaction> listTransaction = [];
  @override
  void initState() {
    super.initState();
    _getListRoomTr();
  }

  Future<void> _getListRoomTr() async {
    setState(() {
      onLoading = true;
    });
    RoomService.getListTransaction(1).then((value) {
      setState(() {
        listTransaction = value;
        onLoading = false;
      });
    });
  }

  Widget statusText(int status) {
    if (status == 1) {
      return const Text(
        'Lunas',
        style: TextStyle(
          color: Colors.green,
        ),
      );
    } else {
      return const Text(
        'Belum Lunas',
        style: TextStyle(color: Colors.red),
      );
    }
  }

  Widget statusIcon(String status) {
    if (status == 'done') {
      return const Icon(
        Icons.done_rounded,
        color: Colors.green,
        size: 40,
      );
    } else if (status == 'active') {
      return const Icon(
        Icons.change_circle,
        color: Colors.amber,
        size: 40,
      );
    } else {
      return const Icon(
        Icons.cancel_rounded,
        color: Colors.red,
        size: 40,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return onLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.all(10),
                child: const Text(
                  "Transaksi Kamar",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: RefreshIndicator(
                    onRefresh: _getListRoomTr,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        RoomTransaction data = listTransaction[index];
                        return Card(
                          child: ListTile(
                            leading: statusIcon(data.status!),
                            title: Text(
                              "Rp. ${numberFormat.format(data.price)}",
                              style: const TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                'Kamar ${data.room!.roomNumber}, ${DateFormat.yMMMd().format(DateTime.parse(data.createdAt!))}'),
                            trailing: statusText(
                                listTransaction[index].paymentStatus!),
                          ),
                        );
                      },
                      itemCount: listTransaction.length,
                    ),
                  ),
                ),
              )
            ],
          );
  }
}
