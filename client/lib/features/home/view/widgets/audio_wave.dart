import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AudioWave extends StatefulWidget {
  final String path;
  const AudioWave({super.key,required this.path,});

  @override
  State<AudioWave> createState() => _AudioWaveState();
}

class _AudioWaveState extends State<AudioWave> {
  final PlayerController playerController = PlayerController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAudioPlayer();
  }

  Future<void> playAndPause()async{
    if(!playerController.playerState.isPlaying){
      await playerController.startPlayer(finishMode: FinishMode.loop,forceRefresh: true);
    }
    //TODO : not palying after it finishes
    // else if(playerController.playerState.isStopped){
    //   await playerController.startPlayer(finishMode: FinishMode.loop);
    // }
    else if(!playerController.playerState.isPaused){
      await playerController.pausePlayer();
    }
    setState(() {

    });
  }

  void initAudioPlayer ()async{
    await playerController.preparePlayer(path: widget.path);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: playAndPause, icon: Icon(
            playerController.playerState.isPlaying ? CupertinoIcons.pause_solid :
            CupertinoIcons.play_arrow_solid
        )
        ),
        Expanded(child: AudioFileWaveforms(
            size: const Size(double.infinity, 100),
            playerController: playerController,
            playerWaveStyle: PlayerWaveStyle(
              fixedWaveColor: Pallete.borderColor,
              liveWaveColor: Pallete.gradient2,
              spacing: 6,
              showSeekLine: true,
            ),
          waveformType: WaveformType.long,
        )
        ),
      ],
    );
  }
}
