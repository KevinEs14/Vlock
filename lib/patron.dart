import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:vlock/pin.dart';
import 'package:vlock/voicePage.dart';
import 'package:collection/collection.dart';


class Patron extends StatefulWidget {
  @override
  _PatronState createState() => _PatronState();
}

class _PatronState extends State<Patron> {
  Size size;
  @override
  Widget build(BuildContext context) {

    size=MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width:size.width,
            color:Color(0xff99091A),
            height: size.height*0.1,

            child:
              Center(
                child:
                Text("Ingrese el patrón",style: TextStyle(fontSize: 21,color: Colors.white),),
              )
          ),
          Container(
              width:size.width*0.7,
              height: size.width*0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width*0.1),
                border: Border.all(color: Color(0xff99091A),)
              ),
              child: PatternLock(
            selectedColor: Color(0xff99091A),
            notSelectedColor: Color(0xff99091A).withOpacity(0.5),
            pointRadius: 8,
            showInput: true,
            dimension: 4,
            relativePadding: 0.7,
            selectThreshold: 25,
            // whether fill points.
            fillPoints: true,
            onInputComplete: (List<int> input) {
              Function eq = const ListEquality().equals;
              if(eq(input,[0, 1, 5, 6, 10, 11, 15])){
              print(input);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Pin()));
              }
            },
          ))
        ],
      ),
    );
  }
}
