import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
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
    return Scaffold(
      body: Center(
        child: CameraAwesomeBuilder.awesome(
          saveConfig:
              SaveConfig.photoAndVideo(photoPathBuilder: (sensors) async {
            final Directory extDir = await getTemporaryDirectory();
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
          onMediaCaptureEvent: (mediaCaptureEvent) {},
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
