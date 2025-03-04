import 'dart:io';

import 'package:flutter_imagekit/flutter_imagekit.dart';

class FileUploadService {
  Future<String?> uploadFile(File file) async {
    final fileUrl = await ImageKit.io(file,
        privateKey: 'private_JXvo+fiuVFu7ML7YYNDkYl0Rvbo=',
        onUploadProgress: (progressValue) {
      print(progressValue);
    });
    return fileUrl;
  }
}
