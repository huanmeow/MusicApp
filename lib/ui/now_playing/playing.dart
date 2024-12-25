import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/model/song.dart';
import 'audio_player_manager.dart';

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

class _NowPlayingPageState extends State<NowPlayingPage> with SingleTickerProviderStateMixin {
  late AnimationController _imageAnimController;
  late AudioPlayerManager _audioPlayerManager;
  @override
  void initState(){
    super.initState();
    _imageAnimController = AnimationController(vsync: this, duration: const Duration(milliseconds: 12000),


    );
    _audioPlayerManager = AudioPlayerManager(songUrl: widget.playingSong.source);
    _audioPlayerManager.init();
  }
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const delta = 64;
    final radius = (screenWidth - delta)/2;
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
      child: Scaffold(
        body: Center (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.playingSong.album)
              ,const SizedBox(height: 16,),
              const Text('_ ___ _'),
              const SizedBox(height: 48,
              ),
              RotationTransition(turns:Tween(begin: 0.0, end: 1.0).animate(_imageAnimController),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/itunes.jpg",
                  image: widget.playingSong.image,
                  width: screenWidth - delta,
                  height: screenWidth - delta,
                  imageErrorBuilder: (context, error, stackTrace){
                    return Image.asset('assets/itunes.jpg', width: screenWidth - delta, height: screenWidth - delta,);
                  },
                )
              ),
              ),
              Padding(padding: const EdgeInsets.only(top: 64, bottom: 16)
              ,
              child: SizedBox(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(onPressed: (){}, icon: const Icon(Icons.share_outlined),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Column(
                    children: [
                      Text(widget.playingSong.title,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).textTheme.bodyMedium!.color),
                      ),
                     const SizedBox(height: 8),
                      Text(widget.playingSong.artist,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium!.color),
                      ),
                    ],
                  ),
                  IconButton(onPressed: (){}, icon:const Icon(Icons.favorite_outline),color: Theme.of(context).colorScheme.primary,)
                ],
              ),),
              ),
              Padding(padding: const EdgeInsets.only(top: 32, right: 24, bottom: 16,),
              child: _progressBar(),


              )
            ],
          ),
        )
      )
    );
  }
  StreamBuilder<DurationState> _progressBar(){
    return StreamBuilder<DurationState> (
        stream:  _audioPlayerManager.durationState,
        builder: (context, snapshot){
          final durationState = snapshot.data;
          final progress = durationState?.progress ?? Duration.zero;
          final total = durationState?.total ?? Duration.zero;
          return ProgressBar(progress: progress, total: total,);
        });

  }
}
