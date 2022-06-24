class RoomPhoto {
  int id;
  String text;
  int roomId;
  String createdAt;
  String updatedAt;

  RoomPhoto({
    required this.id,
    required this.text,
    required this.roomId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RoomPhoto.fromJson(Map<String, dynamic> json) {
    return RoomPhoto(
      id: json['id'],
      text: json['text'],
      roomId: json['room_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
