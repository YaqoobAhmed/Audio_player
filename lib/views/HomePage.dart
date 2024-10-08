import 'package:audio_player_/views/FavoriteScreen.dart';
import 'package:audio_player_/views/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audio_player_/controller/song_provider.dart';
import 'package:audio_player_/views/MusicPlayerScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoggingOut = false;
  String _searchQuery = "";

  Future<void> logout(BuildContext context) async {
    setState(() {
      _isLoggingOut = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel',
                  style: TextStyle(color: Colors.orangeAccent)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.orangeAccent),
              ),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      logout(context);
    }
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Songs",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                Wrap(
                  children: [
                    CircleAvatar(
                      child: IconButton(
                        icon: const Icon(Icons.favorite_border_rounded),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FavoritesScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 5),
                    CircleAvatar(
                      child: IconButton(
                        icon: const Icon(
                          Icons.logout_rounded,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          _confirmLogout(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: height * 0.01),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Audios',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
            SizedBox(height: height * 0.01),
            Expanded(
              child: FutureBuilder(
                future: Provider.of<SongProvider>(context, listen: false)
                    .fetchSongs(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Consumer<SongProvider>(
                      builder: (context, songProvider, child) {
                        final songs = songProvider.songs.where((song) {
                          return song.title
                                  .toLowerCase()
                                  .contains(_searchQuery.toLowerCase()) ||
                              song.artist
                                  .toLowerCase()
                                  .contains(_searchQuery.toLowerCase());
                        }).toList();

                        if (songs.isEmpty) {
                          return const Center(
                              child: Text('No songs available'));
                        }

                        return ListView.builder(
                          itemCount: songs.length,
                          itemBuilder: (context, index) {
                            final song = songs[index];
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(song.artist),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  song.isFavorite
                                                      ? Icons.favorite
                                                      : Icons
                                                          .favorite_border_rounded,
                                                  color: song.isFavorite
                                                      ? Colors.black
                                                      : null,
                                                ),
                                                onPressed: () {
                                                  Provider.of<SongProvider>(
                                                          context,
                                                          listen: false)
                                                      .toggleFavorite(index);
                                                },
                                              ),
                                              const SizedBox(height: 10),
                                              const CircleAvatar(
                                                backgroundColor: Colors.black,
                                                child: Icon(
                                                  Icons.play_arrow_rounded,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
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
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
