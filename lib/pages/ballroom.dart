import 'package:abp_tubes_2/models/ballRoom.dart';
import 'package:abp_tubes_2/pages/detailballroom.dart';
import 'package:abp_tubes_2/services/ballroomservices.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BallroomScreen extends StatefulWidget {
  const BallroomScreen({Key? key}) : super(key: key);

  @override
  State<BallroomScreen> createState() => _BallroomScreenState();
}

class _BallroomScreenState extends State<BallroomScreen> {
  final String baseUrl = 'http://192.168.100.223:8000/';
  var dateNow = DateTime.now();
  late DateTime dateTo;
  bool onLoading = true;

  var marginTen = const EdgeInsets.symmetric(horizontal: 10, vertical: 5);
  List<BallRoom> listBallRoom = [];
  var numberFormat = NumberFormat("#,##0", "id_ID");
  @override
  void initState() {
    super.initState();
    var fromDate = DateFormat('yyyy-MM-dd').format(dateNow);
    dateTo = dateNow.add(const Duration(days: 1));
    var toDate = DateFormat('yyyy-MM-dd').format(dateTo);
    BallRoomService.fetchTodo(fromDate, toDate).then((value) {
      setState(() {
        listBallRoom = value;
        onLoading = false;
      });
    });
  }

  void _getListBallRoom() {
    var fromDate = DateFormat('yyyy-MM-dd').format(dateNow);
    var toDate = DateFormat('yyyy-MM-dd').format(dateTo);
    setState(() {
      onLoading = true;
    });
    BallRoomService.fetchTodo(fromDate, toDate).then((value) => {
          setState(() {
            listBallRoom = value;
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
                        onPressed: _getListBallRoom,
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
                                  builder: (context) => const DetailBallroom()),
                            );
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
                                              "storage/${listBallRoom[index].photos[0].text}",
                                          fit: BoxFit.fitWidth),
                                    ),
                                  )),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(3),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          listBallRoom[index].name,
                                          style: TextStyle(fontSize: 25),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      child:
                                          const Text("Equipment avability: "),
                                    ),
                                    Text(
                                      listBallRoom[index].facility,
                                      style:
                                          listBallRoom[index].facility == "yes"
                                              ? TextStyle(
                                                  backgroundColor: Colors.green,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                )
                                              : TextStyle(
                                                  backgroundColor: Colors.red,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.all(5),
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
                                            "Rp. ${numberFormat.format(listBallRoom[index].price)}",
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
                                                listBallRoom[index]
                                                    .capacity
                                                    .toString(),
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
                                                "${listBallRoom[index].area} m\u{00B2}",
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
                    itemCount: listBallRoom.length,
                  ),
                ),
              ],
            ),
    );
  }
}
