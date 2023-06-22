class Movie {
  final String id;
  final String name;
  final String overview;
  final String poster;

  Movie({
    required this.id,
    required this.name,
    required this.overview,
    required this.poster,
    
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      poster: json['poster_path'],
    );
  }
}
