


class Movie {
  final String title;
  final String year;
  final String imdbID;
  final String poster;
  final String? plot;
  final String? genre;
  final String? imdbRating;



  Movie({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.poster,
    this.plot,
    this.genre,
    this.imdbRating,
    });

    //for search
    factory Movie.fromJson(Map<String, dynamic> json) {
      return Movie(
        title: json['Title'] ?? 'İsim boş',
        year: json['Year']  ?? 'Bilinmiyor',
        imdbID: json['imdbID'] ?? 'Yok',
        poster: json['Poster'] != 'N/A' ? json['Poster'] : '',
      );

    }

    //for detail
     factory Movie.detailFromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? 'İsim boş',
      year: json['Year'] ?? 'Bilinmiyor',
      imdbID: json['imdbID'] ?? 'Yok',
      poster: json['Poster'] != 'N/A' ? json['Poster'] : '',
      plot: json['Plot'],
      genre: json['Genre'],
      imdbRating: json['imdbRating'],
    );
  }



}