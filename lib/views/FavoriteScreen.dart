import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audio_player_/controller/song_provider.dart';
import 'package:audio_player_/views/MusicPlayerScreen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.03),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Favorites",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: height * 0.01),
            Expanded(
              child: Consumer<SongProvider>(
                builder: (context, songProvider, child) {
                  final favoriteSongs = songProvider.songs
                      .where((song) => song.isFavorite)
                      .toList();

                  if (favoriteSongs.isEmpty) {
                    return const Center(
                      child: Text('No favorite songs available'),
                    );
                  }

                  return ListView.builder(
                    itemCount: favoriteSongs.length,
                    itemBuilder: (context, index) {
                      final song = favoriteSongs[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MusicPlayerScreen(song: song),
                              ),
                            );
                          },
                          child: Hero(
                            tag: 'song-${song.title}',
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.orangeAccent,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 2,
                                    color: Colors.black,
                                    offset: Offset(-1, 2),
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            song.imageUrl,
                                            height: height * 0.08,
                                            width: width * 0.15,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              song.title,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(song.artist),
                                          ],
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.favorite,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        // Unfavorite the song
                                        Provider.of<SongProvider>(context,
                                                listen: false)
                                            .toggleFavorite(songProvider.songs
                                                .indexOf(song));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
