// import 'package:crime_lens/models/complain_model.dart';
// import 'package:flutter/material.dart';

// class ComplainDetailsPage extends StatelessWidget {
//   final ComplainModel data;
//   const ComplainDetailsPage({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

import 'package:crime_lens/screens/complain/attachment_preview_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:crime_lens/models/complain_model.dart';

class ComplainDetailsPage extends StatelessWidget {
  final ComplainModel data;
  const ComplainDetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final themeColor = Colors.green;
    final dateFormat = DateFormat('dd MMM yyyy, hh:mm a');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Complain Details'),
        backgroundColor: themeColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('User Details', themeColor),
            _infoRow('Name', data.userDetails.name),
            _infoRow('Aadhar', data.userDetails.aadhar),
            _infoRow('Address', data.userDetails.address),
            _infoRow('Phone', data.userDetails.mobileNumber),
            _infoRow('Email', data.userDetails.email),
            const SizedBox(height: 20),
            _sectionTitle('Incident Details', themeColor),
            _infoRow('Date & Time',
                dateFormat.format(data.incidentDetails.dateTime)),
            _infoRow('Location', data.incidentDetails.location),
            _infoRow('Type', data.incidentDetails.type),
            _infoRow('Description', data.incidentDetails.description),
            const SizedBox(height: 20),
            if (data.suspectDetails != null) ...[
              _sectionTitle('Suspect Details', themeColor),
              _infoRow('Name', data.suspectDetails!.name),
              _infoRow('Gender', data.suspectDetails!.gender),
              _infoRow('DOB', data.suspectDetails!.dob.toString()),
              _infoRow('Address', data.suspectDetails!.address),
              _infoRow('Crime', data.suspectDetails!.crime),
              _infoRow('Status', data.suspectDetails!.status),
              const SizedBox(height: 10),
              if (data.suspectDetails!.image.isNotEmpty)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      data.suspectDetails!.image,
                      height: 180,
                      width: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
            const SizedBox(height: 20),
            if (data.attachmentUrl != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('Attachment', themeColor),
                  Center(
                    child: isImage(data.attachmentUrl!)
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PhotoPreviewPage(
                                        imagePath: 'imagePath',
                                        imageUrl: data.attachmentUrl,
                                      )));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                data.attachmentUrl!,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => VideoPreviewPage(
                                        videoPath: 'videoPath',
                                        videoUrl: data.attachmentUrl,
                                      )));
                            },
                            child: Text('View Video')),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  bool isImage(String url) {
    final lowerUrl = url.toLowerCase();
    return lowerUrl.endsWith('.jpg') ||
        lowerUrl.endsWith('.jpeg') ||
        lowerUrl.endsWith('.png') ||
        lowerUrl.endsWith('.gif') ||
        lowerUrl.endsWith('.bmp') ||
        lowerUrl.endsWith('.webp');
  }

  bool isVideo(String url) {
    final lowerUrl = url.toLowerCase();
    return lowerUrl.endsWith('.mp4') ||
        lowerUrl.endsWith('.mov') ||
        lowerUrl.endsWith('.avi') ||
        lowerUrl.endsWith('.wmv') ||
        lowerUrl.endsWith('.flv') ||
        lowerUrl.endsWith('.mkv') ||
        lowerUrl.endsWith('.webm');
  }
}
