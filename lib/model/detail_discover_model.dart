class MovieDetailDiscover {
  MovieDetailDiscover({
    required this.id,
    required this.originalTitle,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.overview,

    // required this.id,
    //   required this.adult,
    //   required this.backdropPath,
    //   required this.posterPath,
    //   required this.belongstoCollection,
    //   required this.budget,
    //   required this.genres,
    //   required this.homepage,
    //   required this.imdbId,
    //   required this.originalLanguage,
    //   required this.originalTitle,
    //   required this.overview,
    //   required this.popularity,
    //   required this.productionCompanies,
    //   required this.productionCountries,
    //   required this.releaseDate,
    //   required this.revenue,
    //   required this.runtime,
    //   required this.spokenLanguages,
    //   required this.status,
    //   required this.tagline,
    //   required this.title,
    //   required this.video,
    //   required this.voteAverage,
    //   required this.voteCount
  });

  final String id;
  final String originalTitle;
  final String backdropPath;
  final String releaseDate;
  final double voteAverage;
  final String overview;

  // final int id;
  // final bool adult;
  // final String backdropPath;
  // final String posterPath;
  // final String belongstoCollection;
  // final int budget;
  // final List genres;
  // final String homepage;
  // final String imdbId;
  // final String originalTitle;
  // final String originalLanguage;
  // final String overview;
  // final double popularity;
  // final List productionCompanies;
  // final List productionCountries;
  // final String releaseDate;
  // final int revenue;
  // final int runtime;
  // final List spokenLanguages;
  // final String status;
  // final String tagline;
  // final String title;
  // final bool video;
  // final double voteAverage;
  // final int voteCount;

  factory MovieDetailDiscover.fromJson(Map<String, dynamic> json) =>
      MovieDetailDiscover(
          id: json["id"].toString(),
          backdropPath: json["backdrop_path"],
          originalTitle: json["title"],
          releaseDate: json["release_date"],
          voteAverage: json["vote_average"].toDouble(),
          overview: json["overview"]);

  // id: json["id"] ?? "",
  // adult: json["adult"],
  // backdropPath: json["backdrop_path"] ?? "",
  // posterPath: json["poster_path"],
  // belongstoCollection: json["belongs_to_collection"] ?? "",
  // budget: json["budget"] ?? "",
  // genres: json["genres"] ?? "",
  // homepage: json["homepage"] ?? "",
  // imdbId: json["imdb_id"] ?? "",
  // originalLanguage: json["original_language"] ?? "",
  // originalTitle: json["original_title"] ?? "",
  // overview: json["overview"] ?? "",
  // popularity: json["popularity"] ?? "",
  // productionCompanies: json["production_companies"] ?? "",
  // productionCountries: json["production_countries"] ?? "",
  // releaseDate: json["release_date"] ?? "",
  // revenue: json["revenue"] ?? "",
  // runtime: json["runtime"] ?? "",
  // spokenLanguages: json["spoken_languages"] ?? "",
  // status: json["status"] ?? "",
  // tagline: json["tagline"] ?? "",
  // title: json["title"] ?? "",
  // video: json["video"] ?? "",
  // voteAverage: json["vote_average"].toDouble() ?? "",
  // voteCount: json["vote_count"] ?? "");

  Map<String, dynamic> toJson() => {
        "id": id,
        // "adult": adult,
        "backdrop_path": backdropPath,
        // "poster_path": posterPath,
        // "belongs_to_collection": belongstoCollection,
        // "budget": budget,
        // "genres": genres,
        // "homepage": homepage,
        // "imdb_id": imdbId,
        // "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        // "popularity": popularity,
        // "production_companies": productionCompanies,
        // "production_countries": productionCountries,
        "release_date": releaseDate,
        // "revenue": revenue,
        // "runtime": runtime,
        // "spoken_languages": spokenLanguages,
        // "status": status,
        // "tagline": tagline,
        // "title": title,
        // "video": video,
        "vote_average": voteAverage,
        // "vote_count": voteCount
      };
}
