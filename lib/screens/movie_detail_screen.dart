
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/movie_detail_vm.dart';
import '../widgets/fav_button.dart'; 

class MovieDetailScreen extends StatelessWidget {
  final String imdbID;
  const MovieDetailScreen({super.key, required this.imdbID});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieDetailViewModel()..load(imdbID),
      child: Consumer<MovieDetailViewModel>(
        builder: (_, vm, __) {
          final isLoading = vm.isLoading;
          final err = vm.error;
          final m = vm.movie;

          return Scaffold(
            appBar: AppBar(
              title: Text(m?.title ?? "Film Detayı"),
              actions: [
                if (m != null)
                  FavButtonImdb(
                    imdbId: imdbID,
                    title: m.title,
                    posterUrl: (m.poster.isNotEmpty && m.poster != 'N/A') ? m.poster : null,
                    year: m.year,
                  ),
              ],
            ),
            body: Builder(
              builder: (_) {
                if (isLoading) return const Center(child: CircularProgressIndicator());
                if (err != null) return Center(child: Text(err));
                if (m == null) return const Center(child: Text("Film bulunamadı"));

                // 
                final genres = (m.genre != null && m.genre!.trim().isNotEmpty && m.genre != 'N/A')
                    ? m.genre!.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList()
                    : <String>[];

                final hasRating = (m.imdbRating != null && m.imdbRating!.isNotEmpty && m.imdbRating != 'N/A');

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (m.poster.isNotEmpty && m.poster != 'N/A')
                        Center(child: Image.network(m.poster, height: 280, fit: BoxFit.cover)),
                      const SizedBox(height: 16),

                      // Başlık
                      Text(
                        m.title,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 12),

                      // içeirk
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          if (m.year.isNotEmpty) InfoPill(text: m.year),
                          if (hasRating) InfoPill(text: 'IMDb ${m.imdbRating}', icon: Icons.star_rounded),
                          for (final g in genres) InfoPill(text: g),
                        ],
                      ),

                      const SizedBox(height: 20),
                      // Özet bölümü
                      Section(
                        title: 'Özet',
                        child: Text(m.plot ?? 'Açıklama yok.'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class InfoPill extends StatelessWidget {
  final String text;
  final IconData? icon;
  const InfoPill({super.key, required this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withOpacity(0.75),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cs.outline.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

/// Özet başlığı 
class Section extends StatelessWidget {
  final String title;
  final Widget child;
  const Section({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest.withOpacity(0.45),
            borderRadius: BorderRadius.circular(14),
          ),
          child: DefaultTextStyle.merge(
            style: TextStyle(color: cs.onSurface),
            child: child,
          ),
        ),
      ],
    );
  }
}
