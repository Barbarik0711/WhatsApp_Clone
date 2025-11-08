import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';


class CameraView extends StatelessWidget {
  const CameraView({super.key,required this.path});
  final String path;
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
        child: Image.file(File(path),
        fit: BoxFit.cover,),
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
            )
          ],
        ),
      ),
    );
  }
}