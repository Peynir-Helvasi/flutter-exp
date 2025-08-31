
//model oluşturulmadı. modelden oluşturulacak!!

import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteItem {
  final String imdbId;      
  final String? title;
  final String? posterUrl;
  final String? year;
  final DateTime? createdAt;

  FavoriteItem({
    required this.imdbId,
    this.title,
    this.posterUrl,
    this.year,
    this.createdAt,
  });

  factory FavoriteItem.fromDoc(DocumentSnapshot<Map<String, dynamic>> d) {
    final data = d.data() ?? {};
    return FavoriteItem(
      imdbId: d.id,
      title: data['title'] as String?,
      posterUrl: data['posterUrl'] as String?,
      year: data['year'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}

class FavoritesService {
  final _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _col(String uid) =>
      _db.collection('users').doc(uid).collection('favorites');

  //  favori listesi
  Stream<List<FavoriteItem>> favorites(String uid) {
    return _col(uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((s) => s.docs.map(FavoriteItem.fromDoc).toList());
  }

  // filmin favori olup olmadığı
  Stream<bool> isFavoriteStream(String uid, String imdbId) {
    return _col(uid).doc(imdbId).snapshots().map((d) => d.exists);
  }

  // IMDb ID  ekle  çıkar
  Future<void> toggleByImdb({
    required String uid,
    required String imdbId,
    String? title,
    String? posterUrl,
    String? year,
  }) async {
    final ref = _col(uid).doc(imdbId);
    final exists = (await ref.get()).exists;
    if (exists) {
      await ref.delete();
    } else {
      await ref.set({
        'title': title,
        'posterUrl': posterUrl,
        'year': year,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }
}

final favoritesService = FavoritesService();
