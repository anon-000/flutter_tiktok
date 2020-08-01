import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/1/2020 1:26 AM
///




class MusicDetailsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("@angelPriya", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),),
              )),
          Text("Kmt nagila j ? #myTikTok #instaModel \n #muBHebyHeroine", style: TextStyle(color: Colors.white),),
          SizedBox(height: 8,),
          Row(
            children: [
              Icon(Icons.music_note, color: Colors.white),
              SizedBox(width: 15,),
              Text("Original sound - Rangabati", style: TextStyle(color: Colors.white),)
            ],
          )
        ],
      ),
    );
  }
}
