

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService{

  //kütüphane yüklemesi başarısız olduğu için burdan kullanulmaya devam ediliyor. daha sonrasında env den çekilecekk !!!!!
  static const String _baseUrl = "http://www.omdbapi.com/";
  static const String _apiKey = "cb41e877";


  //search f
  static Future<List<Movie>> fetchMovies(String query) async{
    final url = Uri.parse("$_baseUrl?apikey=$_apiKey&s=$query");

    final response = await http.get(url);

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
  
  //search F
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


}