import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/model/song.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({super.key, required this.playingSong, required this.songs});
  final Song playingSong;
  final List<Song> songs;
  @override
  Widget build(BuildContext context) {
    return NowPlayingPage(
      songs: songs,
      playingSong: playingSong,
    );
  }
}

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({super.key, required this.songs,required this.playingSong});
  final Song playingSong;
  final List<Song> songs;
  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  @override
  Widget build(BuildContext context) {
    // return const Scaffold(
    //   body: Center(
    //     child: Text('Now Playing'),
    //   )
    // );
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar (
        middle: const Text (

          'Now Playing',
        ),
        trailing: IconButton(onPressed: (){}, icon : const Icon(Icons.more_horiz),
      )
      ),
      child: const Center (
        child: const Text('Now Playing Page'),
      )

    );
  }
}
