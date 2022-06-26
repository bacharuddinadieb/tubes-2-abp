class RoomTransaction {
  String? fromDate;
  String? toDate;
  int? customerId;
  int? roomId;
  String? updatedAt;
  String? createdAt;
  int? id;

  RoomTransaction(
      {this.fromDate,
      this.toDate,
      this.customerId,
      this.roomId,
      this.updatedAt,
      this.createdAt,
      this.id});

  RoomTransaction.fromJson(Map<String, dynamic> json) {
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    customerId = json['customer_id'];
    roomId = json['room_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['customer_id'] = this.customerId;
    data['room_id'] = this.roomId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
