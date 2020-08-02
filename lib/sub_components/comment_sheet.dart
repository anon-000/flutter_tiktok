import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/2/2020 10:47 AM
///




class CommentSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Comments")
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        color: Colors.white
      ),
    );
  }
}
