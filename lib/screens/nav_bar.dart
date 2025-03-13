import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crime_lens/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeNavigationDrawer extends StatefulWidget {
  const HomeNavigationDrawer({super.key});

  @override
  State<HomeNavigationDrawer> createState() => _HomeNavigationDrawerState();
}

class _HomeNavigationDrawerState extends State<HomeNavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;

    Widget text(AsyncSnapshot snapshots) {
      String _name = snapshots.data.get('name');
      return Text(_name, style: TextStyle(fontSize: 20, color: Colors.white));
    }

    return StreamBuilder<DocumentSnapshot>(
        stream:
            FirebaseFirestore.instance.collection('user').doc(uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          bool isLoaded = snapshot.hasData;
          return isLoaded
              ? Drawer(
                  child: Material(
                    color: Colors.green,
                    child: ListView(
                      children: [
                        SizedBox(height: height * 0.01),

                        //title
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: 'Crime',
                                style: GoogleFonts.quicksand(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: 'Lens',
                                style: GoogleFonts.quicksand(
                                    color: Colors.red,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold))
                          ])),
                        ),
                        SizedBox(height: height * 0.03),

                        //Profile
                        InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://thumbs.dreamstime.com/b/vector-illustration-isolated-white-background-user-profile-avatar-black-line-icon-user-profile-avatar-black-solid-icon-121102166.jpg?w=768'),
                                  radius: width * 0.1,
                                  backgroundColor: Colors.white,
                                ),
                                SizedBox(width: width * 0.04),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    text(snapshot),
                                    SizedBox(height: 5),
                                    Text('${user.email}',
                                        style:
                                            TextStyle(color: Colors.white70)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Divider(
                            color: Colors.brown,
                            thickness: 1.2,
                          ),
                        ),

                        //SignOut
                        SizedBox(height: height * 0.01),
                        ListTile(
                          leading: Icon(Icons.power_settings_new,
                              color: Colors.white),
                          title: Text(
                            'Sign Out',
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () => AuthService().signOut(),
                        )
                      ],
                    ),
                  ),
                )
              : Text('Loading');
        });
  }
}
