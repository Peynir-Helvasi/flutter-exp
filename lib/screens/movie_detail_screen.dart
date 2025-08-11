import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/movie_detail_vm.dart';

class MovieDetailScreen extends StatelessWidget {
  final String imdbID;
  const MovieDetailScreen({super.key, required this.imdbID});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieDetailViewModel()..load(imdbID),
      child: Scaffold(
        appBar: AppBar(title: const Text("Film Detayı")),
        body: Consumer<MovieDetailViewModel>(
          builder: (_, vm, __) {
            if (vm.isLoading) return const Center(child: CircularProgressIndicator());
            if (vm.error != null) return Center(child: Text(vm.error!));
            if (vm.movie == null) return const Center(child: Text("Film bulunamadı"));

            final m = vm.movie!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (m.poster.isNotEmpty)
                    Center(child: Image.network(m.poster, height: 300, fit: BoxFit.cover)),
                  const SizedBox(height: 16),
                  Text(m.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("Yıl: ${m.year}"),
                  if (m.genre != null) Text("Tür: ${m.genre}"),
                  if (m.imdbRating != null) Text("IMDB: ${m.imdbRating}"),
                  const SizedBox(height: 12),
                  Text(m.plot ?? "Açıklama yok."),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
