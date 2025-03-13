import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:crime_lens/screens/complain/complain_form.dart';
import 'package:crime_lens/widgets/empty_widget.dart';
import 'package:crime_lens/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PhotoPreviewPage extends StatelessWidget {
  final String imagePath;
  final String? imageUrl;
  const PhotoPreviewPage({super.key, required this.imagePath, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview"),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: imageUrl == null
                        ? FileImage(File(imagePath))
                        : NetworkImage(imageUrl!))),
          )),
          imageUrl == null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                            child: OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Retake'))),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Expanded(
                            child: FilledButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ComplainForm(
                                            attachment: File(imagePath),
                                          )));
                                },
                                child: Text('Proceed'))),
                      ],
                    ),
                  ),
                )
              : const EmptyWidget(),
          const SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }
}

class VideoPreviewPage extends StatefulWidget {
  final String? videoUrl;
  final String videoPath;
  const VideoPreviewPage({super.key, required this.videoPath, this.videoUrl});

  @override
  State<VideoPreviewPage> createState() => _VideoPreviewPageState();
}

class _VideoPreviewPageState extends State<VideoPreviewPage> {
  late VideoPlayerController videoPlayerController;

  ChewieController? chewieController;
  late Chewie playerWidget;

  void intializeController() async {
    if (widget.videoUrl != null) {
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl!));
    } else {
      videoPlayerController =
          VideoPlayerController.file(File(widget.videoPath));
    }
    await videoPlayerController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
    );

    playerWidget = Chewie(
      controller: chewieController!,
    );
    setState(() {});
  }

  @override
  void initState() {
    intializeController();
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview"),
      ),
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: chewieController != null &&
                    chewieController!.videoPlayerController.value.isInitialized
                ? Chewie(controller: chewieController!)
                : const LoadingWidget(),
          )),
          widget.videoUrl == null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                            child: OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Retake'))),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Expanded(
                            child: FilledButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ComplainForm(
                                            attachment: File(widget.videoPath),
                                          )));
                                },
                                child: Text('Proceed'))),
                      ],
                    ),
                  ),
                )
              : const EmptyWidget(),
          const SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }
}
