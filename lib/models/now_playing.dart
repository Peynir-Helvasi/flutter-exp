


class NowPlaying {
  final String title;
  final String year;
  final int id;
  final String? poster;
  

  //cons
  NowPlaying({
    required this.title,
    required this.year,
    required this.id,
    required this.poster
    
});



factory NowPlaying.fromJson(Map<String, dynamic> json) {
   
   final String? poster = (json['poster_path'] is String && (json['poster_path'] as String).isNotEmpty)
        ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
        : null;
  
  
  return NowPlaying(

    title: json['title'] ?? 'empty',
    year: json['release_date'] ?? 'empty',
    id: json['id'] ?? '',
    poster: poster,
    );

}



}