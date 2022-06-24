

import 'package:abp_tubes_2/models/room_photo.dart';

class Room {
  int id;
  String roomNumber;
  String type;
  String roomArea;
  int price;
  String floor;
  String createdAt;
  String updatedAt;
  List<RoomPhoto> photos;

  Room(
      {required this.id,
      required this.roomNumber,
      required this.type,
      required this.roomArea,
      required this.price,
      required this.floor,
      required this.createdAt,
      required this.updatedAt,
      required this.photos});

  factory Room.fromJson(Map<String, dynamic> json) {
    var photos = <RoomPhoto>[];
    if (json['photos'] != null) {
      json['photos'].forEach((v) {
        photos.add(RoomPhoto.fromJson(v));
      });
    }
    return Room(
      id: json['id'],
      roomNumber: json['room_number'],
      type: json['type'],
      roomArea: json['room_area'],
      price: json['price'],
      floor: json['floor'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      photos: photos,
    );
  }
}
