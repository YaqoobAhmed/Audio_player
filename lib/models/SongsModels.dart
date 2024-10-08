import 'package:cloud_firestore/cloud_firestore.dart';

class Song {
  final String title; // Changed from name to title for clarity
  final String artist; // Added field for artist
  final String audioUrl; // Added field for audio URL
  final String imageUrl; // Added field for image URL
  bool isFavorite; // Mutable property

  Song({
    required this.title,
    required this.artist,
    required this.audioUrl,
    required this.imageUrl,
    this.isFavorite = false,
  });

  // Method to create a Song from Firestore document
  factory Song.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Song(
      title: data['title'] ?? '', // Ensure fallback if null
      artist: data['artist'] ?? '', // Ensure fallback if null
      audioUrl: data['audioUrl'] ?? '', // Ensure fallback if null
      imageUrl: data['imageUrl'] ?? '', // Ensure fallback if null
      isFavorite: data['isFav'] ?? false, // Ensure fallback if null
    );
  }
}
