import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crime_lens/models/complain_model.dart';
import 'package:crime_lens/services/database_services.dart';
import 'package:crime_lens/widgets/key_value_text.dart';
import 'package:crime_lens/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CriminalDetailsPage extends StatelessWidget {
  final String uid;
  const CriminalDetailsPage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criminal Details'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('criminal')
              .doc(uid)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return LoadingWidget();
            if (snapshot.connectionState == ConnectionState.active) {
              final data = snapshot.data;
              print(data!.get('name'));
              return SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30.0,
                      ),
                      Center(
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(data.get('image')),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      KeyValueText(
                          keyText: 'Name: ', valueText: data.get('name')),
                      const SizedBox(
                        height: 12.0,
                      ),
                      KeyValueText(
                          keyText: 'Gender: ', valueText: data.get('gender')),
                      const SizedBox(
                        height: 12.0,
                      ),
                      KeyValueText(
                          keyText: 'Crime: ', valueText: data.get('crime')),
                      const SizedBox(
                        height: 12.0,
                      ),
                      KeyValueText(
                          keyText: 'Status: ', valueText: data.get('status')),
                      const SizedBox(
                        height: 12.0,
                      ),
                      KeyValueText(
                          keyText: 'Date of Birth: ',
                          valueText: DateFormat('dd MMM, yyyy')
                              .format(data.get('dob').toDate())),
                      const SizedBox(
                        height: 12.0,
                      ),
                      KeyValueText(
                          keyText: 'Address: ', valueText: data.get('address')),
                      const SizedBox(
                        height: 12.0,
                      ),
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: Text('Error'),
            );
          }),
    );
  }
}
