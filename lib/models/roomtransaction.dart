import 'package:abp_tubes_2/models/room.dart';

class RoomTransaction {
  int? id;
  String? fromDate;
  String? toDate;
  int? price;
  int? paymentStatus;
  String? status;
  int? customerId;
  int? roomId;
  String? createdAt;
  String? updatedAt;
  Room? room;

  RoomTransaction(
      {this.id,
      this.fromDate,
      this.toDate,
      this.price,
      this.paymentStatus,
      this.status,
      this.customerId,
      this.roomId,
      this.createdAt,
      this.updatedAt,
      this.room});

  RoomTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    price = json['price'];
    paymentStatus = json['payment_status'];
    status = json['status'];
    customerId = json['customer_id'];
    roomId = json['room_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    room = json['room'] != null ? Room.fromJson(json['room']) : null;
  }
}
