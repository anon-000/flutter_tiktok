import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/1/2020 12:54 AM
///



class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider( thickness: 1, color: Colors.white.withOpacity(0.3),),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(icon: Icon(Icons.home, color: Colors.white), iconSize:40,onPressed: (){},),
              IconButton(icon: Icon(Icons.search, color: Colors.white), iconSize:40,onPressed: (){}),
              Image.asset('assets/tiktokhome.png', height: 48,),
              IconButton(icon: Icon(Icons.remove_from_queue,color: Colors.white),iconSize:40, onPressed: (){}),
              IconButton(icon: Icon(Icons.person_outline, color: Colors.white), iconSize:40,onPressed: (){})

            ],
          ),
        )
      ],
    );
  }
}
