import 'dart:convert';

import 'package:abp_tubes_2/models/room.dart';
import 'package:http/http.dart' as http;

class RoomService {
  static Future<List<Room>> fetchTodo(String fromDate, String toDate) async {
    var uri = Uri.parse(
        'http://192.168.1.100:8000/api/room?fromDate=$fromDate&toDate=$toDate');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return parseRoom(response.body);
    } else {
      throw Exception('Failed to load Todo');
    }
  }
}

List<Room> parseRoom(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Room>((json) => Room.fromJson(json)).toList();
}
