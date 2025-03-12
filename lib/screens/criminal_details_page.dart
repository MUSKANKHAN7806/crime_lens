import 'package:crime_lens/widgets/key_value_text.dart';
import 'package:flutter/material.dart';

class CriminalDetailsPage extends StatelessWidget {
  final String uid;
  const CriminalDetailsPage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30.0,
            ),
            CircleAvatar(
              radius: 50,
            ),
            const SizedBox(
              height: 30,
            ),
            KeyValueText(keyText: 'Name: ', valueText: 'Muskan Gupta'),
            const SizedBox(
              height: 12.0,
            ),
            KeyValueText(keyText: 'Age: ', valueText: '26'),
            const SizedBox(
              height: 12.0,
            ),
            KeyValueText(keyText: 'Reason: ', valueText: 'Theft'),
            const SizedBox(
              height: 12.0,
            ),
            // KeyValueText(keyText: 'Name: ', valueText: 'Muskan Gupta'),
            // const SizedBox(height: 12.0,),
          ],
        ),
      ),
    );
  }
}
