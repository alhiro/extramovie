class MovieGenre {
  MovieGenre({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory MovieGenre.fromJson(Map<String, dynamic> json) => MovieGenre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
