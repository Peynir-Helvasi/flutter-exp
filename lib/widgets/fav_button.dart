
import 'package:flutter/material.dart';
import '../services/favorites.dart';
//import '../services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavButtonImdb extends StatelessWidget {
  final String imdbId;         
  final String? title;         
  final String? posterUrl;     
  final String? year;          

  const FavButtonImdb({
    super.key,
    required this.imdbId,
    this.title,
    this.posterUrl,
    this.year,
  });

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid; 
    return StreamBuilder<bool>(
      stream: favoritesService.isFavoriteStream(uid, imdbId),
      builder: (context, snap) {
        final isFav = snap.data ?? false;
        return IconButton(
          icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
          tooltip: isFav ? 'Favorilerden çıkar' : 'Favorilere ekle',
          onPressed: () {
            favoritesService.toggleByImdb(
              uid: uid,
              imdbId: imdbId,
              title: title,
              posterUrl: (posterUrl == 'N/A') ? null : posterUrl,
              year: year,
            );
          },
        );
      },
    );
  }
}
