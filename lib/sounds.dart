import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

final Map<String, String> musicPaths = {
  "Blue": "musics/Blue.mp3",
  "White": "musics/White.mp3",
  "Green" : "musics/Green.mp3",
  "Pink": "musics/Pink.mp3",
  "Brown": "musics/Brown.mp3",
  "Ocean": "musics/Ocean.mp3",
  "Rain": "musics/Rain.mp3",
  "River": "musics/River.mp3",
  "ThunderStrom": "musics/ThunderStrom.mp3",
  "Forest": "musics/Forest.mp3",
  "Alpha": "musics/Alpha.mp3",
  "Beta": "musics/Beta.mp3",
  "Gamma": "musics/Gamma.mp3",
  "Delta": "musics/Delta.mp3",
  "Theta": "musics/Theta.mp3",
  "Aircraft": "musics/Aircraft.mp3",
  "Bus": "musics/Bus.mp3",
  "Car": "musics/Car.mp3",
  "Train": "musics/Train.mp3",
  "Underground": "musics/Underground.mp3"
  // "Coffee Shop": "assets/musics/Coffee Shop.mp3",
  // "City": "assets/musics/City.mp3",
  // "Highway": "assets/musics/Highway.mp3",
  // "Subway": "assets/musics/Subway.mp3",
};

class sounds extends StatefulWidget {
  final AudioPlayer player;
  final Map<String, String> musicPaths;
  final String? name; // Add this line

  const sounds({
    Key? key,
    required this.player,
    required this.musicPaths,
    this.name,
  }) : super(key: key);

  @override
  State<sounds> createState() => _soundsState();

}


class _soundsState extends State<sounds> with TickerProviderStateMixin {
  late TabController _tabController;
  String _currentSong = '';
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = widget.player;
    _tabController = TabController(length: musicData.length, vsync: this);
  }

  final Map<String, List<String>> musicData = {
    "Favourites": [],
    "Coloured": ["Blue", "White", "Green","Pink", "Brown"],
    "Natural": ["Ocean", "Rain", "River", "ThunderStrom", "Forest"],
    "Binaural": ["Alpha", "Beta", "Gamma", "Delta", "Theta"],
    "Traffic": ["Aircraft", "Bus", "Car", "Train", "Underground"],
  };


  final Map<String, IconData> tabIcons = {
    "Favourites": Icons.favorite,
    "Coloured": Icons.colorize_rounded,
    "Natural": Icons.compost_outlined,
    "Binaural": Icons.compost_outlined,
    "Traffic": Icons.compost_outlined,
  };

  Map<String, bool> _favoriteSongs = {};



  @override
  void dispose() {
    _tabController.dispose();
    player.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 34, 56, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      onTap: (index) => print('Selected tab: $index'),
                      indicatorColor: Colors.white,
                      labelColor: Colors.white,
                      tabs: musicData.keys
                          .map((tabName) => Tab(
                                icon: Icon(tabIcons[tabName]),
                                text: tabName,
                              ))
                          .toList(),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: musicData.entries.map((entry) {
  final tabName = entry.key;
  final musicList = entry.value;
  if (tabName == "Favourites") {
    musicList.retainWhere((songName) =>
        _favoriteSongs[songName] ?? false);
  }
  return musicList.isEmpty
      ? Center(
          child: Text(
            "No favorites added yet!",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      : ListView.builder(
          itemCount: musicList.length,
          itemBuilder: (context, index) {
            final songName = musicList[index];
            final isFavorite = _favoriteSongs[songName] ?? false;
            final songPath = musicPaths[songName]; 

            return SongItem(
              name: songName,
              isFavorite: isFavorite,
              onToggleFavorite: () => toggleFavorite(songName),
              onTap: () async {
  final songPath = musicPaths[songName];
  if (songPath != null) {
    if (_currentSong != songPath) {
      setState(() {
        _currentSong = songPath;
      });
      await player.setAsset(songPath);
    }
    if (player.playing) {
      await player.pause();
    } else {
      await player.play();
    }
  } else {
    print('Song path not found for $songName');
  }
},
              currentSong: _currentSong,
              player: player,
              songPath: songPath!,
            );
          },
        );
}).toList(),

                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void toggleFavorite(String songName) {
    setState(() {
      if (_favoriteSongs.containsKey(songName)) {
        _favoriteSongs.remove(songName);
        musicData["Favourites"]?.remove(songName);
      } else {
        _favoriteSongs[songName] = true;
        musicData["Favourites"]?.add(songName);
      }
    });
  }
}

class SongItem extends StatefulWidget {
  final String name;
  final bool isFavorite;
  final Function() onToggleFavorite;
  final Function() onTap;
  final String currentSong;
  final AudioPlayer player;
  final String songPath;

  const SongItem({
    required this.name,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onTap,
    required this.currentSong,
    required this.player,
    required this.songPath,
  });

  @override
  _SongItemState createState() => _SongItemState();
}

class _SongItemState extends State<SongItem> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          IconButton(
            icon: Icon(
              isPlaying
                  ? Icons.pause_circle_outline_rounded
                  : Icons.play_circle_outline_rounded,
              color: Colors.white,
            ),
            onPressed: () async {
              if (widget.currentSong == widget.name) {
                if (isPlaying) {
                  await widget.player.pause();
                } else {
                  await widget.player.play();
                }
              } else {
                widget.onTap();
              }
              setState(() => isPlaying = !isPlaying);
            },
          ),
          SizedBox(width: 5),
          Text(
            widget.name,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
      trailing: InkWell(
        onTap: widget.onToggleFavorite,
        child: Icon(
          widget.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: widget.isFavorite ? Colors.red : Colors.white,
          size: 24,
        ),
      ),
    );
  }
}