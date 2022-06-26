import 'package:abp_tubes_2/models/ballRoom_photo.dart';

class BallRoom {
  int id;
  String name;
  String floor;
  String area;
  int price;
  String? capacity;
  String facility;
  String? createdAt;
  String? updatedAt;
  List<ballRoomPhoto> photos;

  BallRoom(
      {required this.id,
      required this.name,
      required this.floor,
      required this.area,
      required this.price,
      required this.capacity,
      required this.facility,
      required this.createdAt,
      required this.updatedAt,
      required this.photos});

  factory BallRoom.fromJson(Map<String, dynamic> json) {
    var photos = <ballRoomPhoto>[];
    if (json['photos'] != null) {
      json['photos'].forEach((v) {
        photos.add(ballRoomPhoto.fromJson(v));
      });
    }
    return BallRoom(
      id: json['id'],
      name: json['name'],
      floor: json['floor'],
      area: json['area'],
      price: json['price'],
      capacity: json['capaciy'],
      facility: json['facility'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      photos: photos,
    );
  }
}
