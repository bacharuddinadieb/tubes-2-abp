class ballRoomPhoto {
  int id;
  String text;
  int ballroomId;
  String createdAt;
  String updatedAt;

  ballRoomPhoto({
    required this.id,
    required this.text,
    required this.ballroomId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ballRoomPhoto.fromJson(Map<String, dynamic> json) {
    return ballRoomPhoto(
      id: json['id'],
      text: json['text'],
      ballroomId: json['ballroom_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
