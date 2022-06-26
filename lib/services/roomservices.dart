import 'dart:convert';

import 'package:abp_tubes_2/models/room.dart';
import 'package:abp_tubes_2/models/roomtransaction.dart';
import 'package:abp_tubes_2/services/globals.dart';
import 'package:http/http.dart' as http;

class RoomService {
  static Future<List<Room>> fetchTodo(String fromDate, String toDate) async {
    var uri = Uri.parse(URL + 'api/room?fromDate=$fromDate&toDate=$toDate');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return parseRoom(response.body);
    } else {
      throw Exception('Failed to load Todo');
    }
  }

  static Future<RoomTransaction?> orderRoom(
      String fromDate, String toDate, int roomId) async {
    var uri = Uri.parse(URL + 'api/room/transaction');

    final Map<String, dynamic> body = {
      "fromDate": fromDate,
      "toDate": toDate,
      "customer_id": 1,
      "room_id": roomId
    };

    final response = await http.post(
      uri,
      body: json.encode(body),
      headers: {
        "content-type": "application/json",
      },
    );

    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      return RoomTransaction(
        id: data['id'],
        createdAt: data['createdAt'],
        updatedAt: data['updatedAt'],
        fromDate: data['fromDate'],
        toDate: data['toDate'],
        roomId: data['roomId'],
        customerId: data['customerId'],
      );
    } else {
      return null;
    }
  }

  static Future<List<RoomTransaction>> getListTransaction(int userId) async {
    var uri = Uri.parse(URL + 'api/room/transaction?userId=$userId');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return parseRoomTransaction(response.body);
    } else {
      return [];
    }
  }
}

List<Room> parseRoom(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Room>((json) => Room.fromJson(json)).toList();
}

List<RoomTransaction> parseRoomTransaction(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<RoomTransaction>((json) => RoomTransaction.fromJson(json))
      .toList();
}
