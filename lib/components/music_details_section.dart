import 'dart:async';

import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/1/2020 1:26 AM
///




class MusicDetailsSection extends StatefulWidget {
  final String name ;
  MusicDetailsSection({this.name});

  @override
  _MusicDetailsSectionState createState() => _MusicDetailsSectionState();
}

class _MusicDetailsSectionState extends State<MusicDetailsSection> {
  ScrollController scrollController;
  bool isReverse = false;

  Timer _timer;
  String myString ='';

  void animate() async{

    if(scrollController.positions.isNotEmpty){
      while(true) {

        await scrollController.animateTo(
            0.0, duration: new Duration(milliseconds: 400),
            curve: Curves.ease);
        setState(() {
          isReverse = false;
        });
        await scrollController.animateTo(
            scrollController.position.maxScrollExtent ,
            duration: new Duration(seconds: 5), curve: Curves.linear).whenComplete((){
          setState(() {
            isReverse = true;
          });
        });
      }
    }else{
      _timer = new Timer(const Duration(milliseconds: 400), () {
        animate();
      });
    }

  }

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
    myString = 'Original sound - '+ widget.name;
    animate();
  }

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
              Expanded(
                child: SizedBox(
                  height: 20,
                  width: 90,
                  child: ListView(
                    controller: scrollController,
                    shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(width: (myString.length*9).toDouble(),),
                        isReverse?Text(""):Text("Original sound - "+ widget.name??'', style: TextStyle(color: Colors.white),),
                        SizedBox(width: (myString.length*14).toDouble(),)
                      ]),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
