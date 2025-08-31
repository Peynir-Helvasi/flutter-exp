import 'dart:async';

import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/api.dart';
import 'movie_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  Future<List<Movie>>? _future;

  Timer? _debounce;
  static const _debounceMs = 450;



  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void onChanged(String text) {
  _debounce?.cancel();
  final q = text.trim();
  _debounce = Timer(const Duration(milliseconds: _debounceMs), () {
    if (!mounted) return;

    if (q.isEmpty) {
      setState(() {                      
        _future = null;
      });
    } else {
      final future = ApiService.fetchMovies(q); 
      setState(() {_future = future;});
    }
  });
}



  // void _doSearch() {
  //   final q = _controller.text.trim();
  //   if (q.isEmpty) return;
  //   setState(() {
  //     _future = ApiService.fetchMovies(q);
  //   });
  // }

  Widget _posterThumb(String url) {
    if (url.isEmpty) {
      return const SizedBox(
        width: 50,
        height: 50,
        child: Icon(Icons.image_not_supported),
      );
    }
    return Image.network(
      url,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const SizedBox(
        width: 50,
        height: 50,
        child: Icon(Icons.broken_image),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Film Ara')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.search,
                    onChanged: onChanged,
                    decoration: const InputDecoration(
                      hintText: 'Örn: Batman',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
          Expanded(
            child: _future == null
                ? const Center(child: Text(''))
                : FutureBuilder<List<Movie>>(
                    future: _future,
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snap.hasError) {
                        return Center(child: Text('Hata: ${snap.error}'));
                      }
                      final movies = snap.data ?? [];
                      if (movies.isEmpty) {
                        return const Center(child: Text('Sonuç bulunamadı.'));
                      }
                      return ListView.separated(
                        itemCount: movies.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (_, i) {
                          final m = movies[i];
                          return ListTile(
                            leading: _posterThumb(m.poster),
                            title: Text(m.title),
                            subtitle: Text(m.year),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      MovieDetailScreen(imdbID: m.imdbID),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
