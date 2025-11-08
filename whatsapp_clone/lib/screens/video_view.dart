import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';


class VideoView extends StatefulWidget {
  const VideoView({super.key,required this.path});
  final String path;
  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
    ..initialize().then((_){
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.crop_rotate,size: 27,color: Colors.white,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.emoji_emotions_outlined,size: 27,color: Colors.white,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.title,size: 27,color: Colors.white,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.edit,size: 27,color: Colors.white,)),
        ],
      ),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Stack(
          children: [
            Container(
               width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).width - 15,
        child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black38,
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                child: TextFormField(
                  maxLength: 6,
                  minLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  decoration: InputDecoration(
                    hintText: "Add Caption...",
                    prefixIcon: Icon(Icons.add_photo_alternate,color: Colors.white,size: 27,),
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    suffixIcon: CircleAvatar(
                      radius: 27,
                      backgroundColor: Colors.tealAccent[700],
                      child: Icon(Icons.save,color: Colors.white,size: 27,),
                    ),
                    
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 33,
                backgroundColor: Colors.black38,
                child: InkWell(
                  onTap:() {
                    setState(() {
                      _controller.value.isPlaying ? _controller.pause() :_controller.play();
                    });
                  },
                  child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white,size: 50,)),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}