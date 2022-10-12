class MovieVideo {
  MovieVideo({
    required this.id,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
  });

  final String id;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;

  factory MovieVideo.fromJson(Map<String, dynamic> json) => MovieVideo(
        id: json["id"].toString(),
        name: json["name"],
        key: json["key"],
        site: json["site"],
        size: json["size"],
        type: json["type"],
        official: json["official"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "key": key,
        "site": site,
        "size": size,
        "type": type,
        "official": official,
      };
}
