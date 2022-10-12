class MovieDiscover {
  MovieDiscover(
      {required this.id,
      required this.adult,
      required this.backdropPath,
      required this.posterPath,
      required this.genreIds,
      required this.originalLanguage,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.releaseDate,
      required this.title,
      required this.video,
      required this.voteAverage,
      required this.voteCount});

  final int id;
  final bool adult;
  final String backdropPath;
  final String posterPath;
  final List genreIds;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  factory MovieDiscover.fromJson(Map<String, dynamic> json) => MovieDiscover(
        id: json["id"],
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        posterPath: json["poster_path"],
        genreIds: json["genre_ids"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"],
        releaseDate: json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "adult": adult,
        "backdrop_path": backdropPath,
        "poster_path": posterPath,
        "genre_ids": genreIds,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "release_date": releaseDate,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
