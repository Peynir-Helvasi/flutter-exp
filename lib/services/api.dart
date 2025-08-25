

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/now_playing.dart';

class ApiService{
 

// for fetching movies and details.
  static final String _baseUrl = dotenv.env['OMDB_API_URL'] ?? '';
  static final String _apiKey = dotenv.env['OMDB_API_KEY'] ?? '';
  
  //for fetcing now playing movies.
  static final String _apiNP = dotenv.env['TMDB_API_KEY'] ?? ''; 
  static final String _urlNP = dotenv.env['TMDB_API_URL'] ?? ''; 
  
  


  //search for titles
  static Future<List<Movie>> fetchMovies(String query) async{
    final url = Uri.parse("$_baseUrl?apikey=$_apiKey&s=$query");
    print(url);
    
    final response = await http.get(url);
    print(response);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =jsonDecode(response.body);

      if(data["Response"] == "True") {
        List<dynamic> moviesJson= data["Search"];
        return moviesJson.map((json) => Movie.fromJson(json)).toList();

      }
      else {
        return [];
      }

    }
    else {
      throw Exception("İstek Başarısız: ${response.statusCode}");

    }

 }
  
  //search for details
   static Future<Movie> fetchMovieDetail(String imdbID) async {
    final url = Uri.parse("$_baseUrl?apikey=$_apiKey&i=$imdbID");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data["Response"] == "True") {
        return Movie.detailFromJson(data);
      } else {
        throw Exception(data["Error"] ?? "Film bulunamadı");
      }
    } else {
      throw Exception("İstek Başarısız: ${response.statusCode}");
    }
  }


// request for now playing.
  static Future<List<NowPlaying>> fetchNowPlaying() async{
    final urlNP = Uri.parse("$_urlNP/movie/now_playing?api_key=$_apiNP&language=tr-TR");


    final responseNP = await http.get(urlNP);
    print(urlNP);

    if (responseNP.statusCode == 200){
      final Map<String, dynamic> dataNP = jsonDecode(responseNP.body) as Map<String, dynamic>;
      final List results = (dataNP['results'] as List);     
        return results.map((e) => NowPlaying.fromJson(e as Map<String, dynamic>)).toList();
        
    } else {
      throw Exception("İstek başarısız:  ${responseNP.statusCode}" );
    }



  }


}