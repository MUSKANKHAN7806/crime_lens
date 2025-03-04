import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crime_lens/models/complain_model.dart';
import 'package:crime_lens/screens/chatbot_screen.dart';
import 'package:crime_lens/screens/complain/camera_page.dart';
import 'package:crime_lens/screens/complain/complain_form.dart';
import 'package:crime_lens/services/auth_services.dart';
import 'package:crime_lens/services/database_services.dart';
import 'package:crime_lens/services/theme.dart';
import 'package:crime_lens/widgets/complain_cards.dart';
import 'package:crime_lens/widgets/heat_map.dart';
import 'package:crime_lens/widgets/loading.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('CrimeLens'),
        actions: [
          ElevatedButton(
              onPressed: () async {
                await AuthService().signOut();
              },
              child: Text('Logout'))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeatmapWidget(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Past Complains',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
            height: 120,
            child: PastComplains(),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Center(
              child: FilledButton(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Raise complain'),
                            content: Text('Choose a method to raise complain'),
                            actionsAlignment: MainAxisAlignment.center,
                            actions: [
                              IconButton.filled(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CameraPage()));
                                  },
                                  icon: Icon(Icons.video_call)),
                              IconButton.filled(
                                  onPressed: () {},
                                  icon: Icon(Icons.spatial_audio_off_rounded)),
                              IconButton.filled(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ComplainForm()));
                                  },
                                  icon: Icon(Icons.edit_document))
                            ],
                          );
                        });
                  },
                  child: Text('Raise Complain')))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(
            side: BorderSide(color: kMeeshoMustard, width: 1.6)),
        backgroundColor: kMeeshoPurple,
        heroTag: 'chatBotFab',
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ChatBotChatScreen()));
        },
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: Center(
            child: Image(image: AssetImage('assets/images/chatbot.png')),
          ),
        ),
      ),
    );
  }
}

class PastComplains extends StatelessWidget {
  const PastComplains({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseDatabaseServices().getComplains(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget();
          }
          if (snapshot.connectionState == ConnectionState.active) {
            final data = snapshot.data;
            if (data != null) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      final docData = data.docs[index].data();
                      final complainData = ComplainModel.fromJson(docData);
                      return ComplainCards(
                        data: complainData,
                      );
                    }),
              );
            }
          }
          return Center(
            child: Text("Some error occured"),
          );
        });
  }
}
