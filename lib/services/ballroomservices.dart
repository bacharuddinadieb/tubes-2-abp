import 'dart:convert';

import 'package:abp_tubes_2/models/ballRoom.dart';
import 'package:http/http.dart' as http;

class BallRoomService {
  static Future<List<BallRoom>> fetchTodo(
      String fromDate, String toDate) async {
    var uri = Uri.parse(
        'http://192.168.100.223:8000/api/ballroom?fromDate=$fromDate&toDate=$toDate');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return parseBallRoom(response.body);
    } else {
      throw Exception('Failed to load Todo');
    }
  }
}

List<BallRoom> parseBallRoom(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<BallRoom>((json) => BallRoom.fromJson(json)).toList();
}
