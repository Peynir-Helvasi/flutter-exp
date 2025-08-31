// liste yapma  kısmı eklenicek buraya 
// database sorununu çöz !!

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/favorites.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return const Scaffold(body: Center(child: Text('Giriş gerekli')));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          
        ],
      ),
      body: StreamBuilder(
        stream: favoritesService.favorites(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = snapshot.data ?? [];
          if (items.isEmpty) return const Center(child: Text('Favori yok'));

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final f = items[i];
              return ListTile(
                leading: (f.posterUrl != null && f.posterUrl!.isNotEmpty)
                    ? Image.network(f.posterUrl!, width: 50, fit: BoxFit.cover)
                    : const Icon(Icons.movie),
                title: Text(f.title ?? f.imdbId),
                subtitle: Text('${f.imdbId} • ${f.year ?? ''}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => favoritesService.toggleByImdb(
                    uid: uid,
                    imdbId: f.imdbId, 
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
