

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService{
 
  

  static final String _baseUrl = dotenv.env['APİ_URL'] ?? '';
  static final String _apiKey = dotenv.env['API_KEY'] ?? '';
  
  static void printF(){
    print(_baseUrl);
    print(_apiKey);
  }


  //search for titles
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


}