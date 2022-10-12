class MovieReviewUser {
  MovieReviewUser({
    required this.id,
    required this.author,
    required this.content,
    required this.createdDate,
  });

  final String id;
  final String author;
  final String content;
  final String createdDate;

  factory MovieReviewUser.fromJson(Map<String, dynamic> json) =>
      MovieReviewUser(
        id: json["id"].toString(),
        author: json["author"],
        content: json["content"],
        createdDate: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "content": content,
        "created_at": createdDate
      };
}
