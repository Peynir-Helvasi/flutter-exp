
//used setState for state management

import 'package:flutter/material.dart';
import '../services/api.dart';
import '../models/movie.dart';
import './movie_detail_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Movie> _movies = [];
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _searchMovies() async{
    final query = _controller.text.trim();

    if(query.isEmpty) {
      setState(() {
        _errorMessage = "Film Adı Griniz.";
        _movies = [];
      });
      return;
    }

    setState(() {
      _isLoading= true;
      _errorMessage = null;
    });

    try{
      final movies = await ApiService.fetchMovies(query);
      setState(() {
        _movies = movies;
        if (movies.isEmpty) {
          _errorMessage = "Sonuç Bulunamadı.";
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Bir hata oluştu: $e";
      });
    } finally {
      setState(() {
        _isLoading =false;
      });
    }


  }

@override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Film Rehberi")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: "Film adı girin",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _searchMovies,
                  child: const Text("Ara"),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // İçerik
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _errorMessage != null
                      ? Center(child: Text(_errorMessage!))
                      : ListView.builder(
                          itemCount: _movies.length,
                          itemBuilder: (context, index) {
                            final movie = _movies[index];
                            return ListTile(
                              leading: movie.poster.isNotEmpty
                                ? Image.network(movie.poster, width: 50, fit: BoxFit.cover)
                                : const Icon(Icons.movie, size: 40),
                              title: Text(movie.title),
                              subtitle: Text(movie.year),
                              onTap: () { // 👈 BURAYA EKLEDİK
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MovieDetailScreen(imdbID: movie.imdbID),
                                    ),
                                );
                              },
                            );
                          },
              ),

            ),
          ],
        ),
      ),
    );
  }


}


