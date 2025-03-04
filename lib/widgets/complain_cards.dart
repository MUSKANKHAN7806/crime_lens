import 'package:crime_lens/models/complain_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ComplainCards extends StatelessWidget {
  final ComplainModel data;
  const ComplainCards({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd MMM, yyyy').format(data.incidentDetails.dateTime);
    String formattedTime =
        DateFormat('h:mm a').format(data.incidentDetails.dateTime);
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: SizedBox(
        width: 200,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.incidentDetails.type,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text('Date: $formattedDate'),
                Text('Time: $formattedTime'),
                Text(data.incidentDetails.location),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
