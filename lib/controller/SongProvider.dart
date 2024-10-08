import 'package:audio_player_/models/SongsModels.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SongProvider with ChangeNotifier {
  List<Song> _songs = [];

  List<Song> get songs => _songs;

  Future<void> fetchSongs() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('songs').get();
    _songs = snapshot.docs.map((doc) => Song.fromFirestore(doc)).toList();
    notifyListeners();
  }

  void toggleFavorite(int index) {
    _songs[index].isFavorite = !_songs[index].isFavorite;
    notifyListeners(); // Update listeners after toggling favorite status
  }
}
