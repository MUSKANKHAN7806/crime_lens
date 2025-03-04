import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:crime_lens/screens/complain/attachment_preview_page.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    int count = 0;
    return Scaffold(
      body: Center(
        child: CameraAwesomeBuilder.awesome(
          saveConfig:
              SaveConfig.photoAndVideo(photoPathBuilder: (sensors) async {
            final Directory extDir = await getApplicationDocumentsDirectory();
            final testDir = await Directory('${extDir.path}/camerawesome')
                .create(recursive: true);

            if (sensors.length == 1) {
              final String filePath =
                  '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
              // 3.
              return SingleCaptureRequest(filePath, sensors.first);
            } else {
              // 4.
              return MultipleCaptureRequest(
                {
                  for (final sensor in sensors)
                    sensor:
                        '${testDir.path}/${sensor.position == SensorPosition.front ? 'front_' : "back_"}${DateTime.now().millisecondsSinceEpoch}.jpg',
                },
              );
            }
          }),
          onMediaCaptureEvent: (mediaCapture) async {
            if (mediaCapture.isPicture && count == 0) {
              count++;
              var imageFile = File(mediaCapture.captureRequest.path!);
              var isFilePresent = await imageFile.exists();
              if (!isFilePresent) {
                await Future.delayed(Duration(seconds: 2)); // Additional wait
                isFilePresent = await imageFile.exists();
                print("File exists after delay? $isFilePresent");
              }

              if (isFilePresent) {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => PhotoPreviewPage(
                            imagePath: mediaCapture.captureRequest.path!)))
                    .then((value) {
                  count = 0;
                });
              }
            }

            if (mediaCapture.isVideo &&
                !mediaCapture.isRecordingVideo &&
                count == 0) {
              count++;
              var videoFile = File(mediaCapture.captureRequest.path!);
              var isFilePresent = await videoFile.exists();
              if (!isFilePresent) {
                await Future.delayed(Duration(seconds: 2)); // Additional wait
                isFilePresent = await videoFile.exists();
                print("File exists after delay? $isFilePresent");
              }

              if (isFilePresent) {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => VideoPreviewPage(
                            videoPath: mediaCapture.captureRequest.path!)))
                    .then((value) {
                  count = 0;
                });
              }
            }
          },
          onMediaTap: (mediaCapture) {
            if (mediaCapture.captureRequest.path != null) {
              OpenFile.open(mediaCapture.captureRequest.path);
            }
          },
        ),
      ),
    );
  }
}
