import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/1/2020 12:14 AM
///

class SideOptionsBar extends StatefulWidget {
  @override
  _SideOptionsBarState createState() => _SideOptionsBarState();
}

class _SideOptionsBarState extends State<SideOptionsBar> {

  Timer _timer;
  double _start = 0;

  void startTimer() {
    const oneSec = const Duration(milliseconds: 150);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
              _start = _start + 0.5;
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 60,
              width: 60,
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        'https://i.pinimg.com/originals/70/da/46/70da46bffa8359c0ba35a57fcdd2d195.jpg'),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 3,
                right: 0,
                left: 0,
                child: Icon(Icons.add_circle, color: Colors.red,)
            )
          ],
        ),
        IconButton(icon: Icon(Icons.favorite, color: Colors.white,), iconSize: 45, onPressed: () {}),
        Text("771.1K", style: TextStyle(color: Colors.white),),
        IconButton(
            icon: Icon(Icons.message_rounded, color: Colors.white), iconSize: 40, onPressed: () {}),
        Text("4078",style: TextStyle(color: Colors.white)),
        IconButton(
            icon: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(pi),
                child: Icon(
                  Icons.reply,color: Colors.white
                )),
            iconSize: 40,
            onPressed: () {}),
        Text("1078",style: TextStyle(color: Colors.white, height: 1)),
        SizedBox(
          height: 30,
        ),
        Transform.rotate(
          angle: _start.toDouble(),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
                "https://yt3.ggpht.com/dPRwuCu0q3vk5YMzKnxnPcQplIBvA7Tmg1wsI3NjsB0JzNe6K3_XTijGi4_Y-M3CCXBti1k27A=s900-c-k-c0xffffffff-no-rj-mo"),
          ),
        )
      ],
    );
  }
}
