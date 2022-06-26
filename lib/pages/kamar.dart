import 'package:abp_tubes_2/models/room.dart';
import 'package:abp_tubes_2/pages/detailkamar.dart';
import 'package:abp_tubes_2/services/globals.dart';
import 'package:abp_tubes_2/services/roomservices.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KamarScreen extends StatefulWidget {
  const KamarScreen({Key? key}) : super(key: key);

  @override
  State<KamarScreen> createState() => _KamarScreenState();
}

class _KamarScreenState extends State<KamarScreen> {
  final String baseUrl = URL;
  var dateNow = DateTime.now();
  late DateTime dateTo;
  bool onLoading = true;

  var marginTen = const EdgeInsets.symmetric(horizontal: 10, vertical: 5);
  List<Room> listRoom = [];
  var numberFormat = NumberFormat("#,##0", "id_ID");
  @override
  void initState() {
    super.initState();
    var fromDate = DateFormat('yyyy-MM-dd').format(dateNow);
    dateTo = dateNow.add(const Duration(days: 1));
    var toDate = DateFormat('yyyy-MM-dd').format(dateTo);
    RoomService.fetchTodo(fromDate, toDate).then((value) {
      setState(() {
        listRoom = value;
        onLoading = false;
      });
    });
  }

  void _getListRoom() {
    var fromDate = DateFormat('yyyy-MM-dd').format(dateNow);
    var toDate = DateFormat('yyyy-MM-dd').format(dateTo);
    setState(() {
      onLoading = true;
    });
    RoomService.fetchTodo(fromDate, toDate).then((value) => {
          setState(() {
            listRoom = value;
            onLoading = false;
          })
        });
  }

  void _setDate() {
    showDatePicker(
      context: context,
      initialDate: dateNow,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    ).then(
      (value) => {
        if (value != null)
          showDatePicker(
            context: context,
            initialDate: value.add(const Duration(days: 1)),
            firstDate: value.add(const Duration(days: 1)),
            lastDate: DateTime(2025),
          ).then((secondValue) => {
                if (secondValue != null)
                  setState(() {
                    dateNow = value;
                    dateTo = secondValue;
                  })
              })
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (onLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: marginTen,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: _setDate,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                            ),
                            margin: const EdgeInsets.only(right: 10),
                            height: 40,
                            child: Text(
                              "${DateFormat('d MMM').format(dateNow)} - ${DateFormat('d MMM').format(dateTo)}",
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _getListRoom,
                        child: const Text("Search"),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailKamar(
                                  room: listRoom[index],
                                  dateFrom: dateNow,
                                  dateTo: dateTo,
                                ),
                              ),
                            ).then((value) {
                              if (value) _getListRoom();
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ), // Image border
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(
                                          48), // Image radius
                                      child: Image.network(
                                          baseUrl +
                                              "storage/${listRoom[index].photos[0].text}",
                                          fit: BoxFit.fitWidth),
                                    ),
                                  )),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    color: Colors.green,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2),
                                      child: Text(
                                        "Breakfast",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    margin: const EdgeInsets.only(
                                        top: 10, left: 10),
                                  ),
                                  Container(
                                    color: Colors.green,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2),
                                      child: Text(
                                        "Wi-Fi",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    margin: const EdgeInsets.only(
                                        top: 10, left: 10),
                                  ),
                                ],
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      child: const Icon(
                                        Icons.hotel,
                                      ),
                                    ),
                                    Text(
                                      listRoom[index].type,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 2,
                                          ),
                                          child: Text(
                                            "Rp. ${numberFormat.format(listRoom[index].price)}",
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.amber,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 2,
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.door_back_door_rounded,
                                                color: Colors.blue,
                                              ),
                                              Text(
                                                listRoom[index].roomNumber,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 2,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                "${listRoom[index].roomArea} m\u{00B2}",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: listRoom.length,
                  ),
                ),
              ],
            ),
    );
  }
}
