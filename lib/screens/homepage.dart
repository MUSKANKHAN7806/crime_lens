import 'package:crime_lens/screens/complain/complain_form.dart';
import 'package:crime_lens/screens/video_complain.dart';
import 'package:crime_lens/services/auth_services.dart';
import 'package:crime_lens/widgets/complain_cards.dart';
import 'package:crime_lens/widgets/heat_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map_heatmap/flutter_map_heatmap.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text('CrimeLens'),actions: [ElevatedButton(onPressed: ()async{await AuthService().signOut();}, child:Text('Logout'))],),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeatmapWidget(),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Past Complains', style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w300),),
          ),
          Container(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ComplainCards(),
                ComplainCards(),
                ComplainCards(),
              ],
            ),
          ),
          const SizedBox(height: 12.0,),
          Center(child: FilledButton(onPressed: ()async{
            await showDialog(context: context, builder: (context){
              return AlertDialog(
                title: Text('Raise complain'),
                        content: Text('Choose a method to raise complain'),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          IconButton.filled(onPressed: (){
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VideoComplain()));
                          }, icon: Icon(Icons.video_call)),
                          IconButton.filled(onPressed: (){}, icon: Icon(Icons.spatial_audio_off_rounded)),
                          IconButton.filled(onPressed: (){
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ComplainForm()));
                          }, icon: Icon(Icons.edit_document))
                     ],
              );
            });
          }, child: Text('Raise Complain')))
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){}, child: Icon(Icons.ac_unit),),
    );
  }
}