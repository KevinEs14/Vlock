import 'package:flutter/material.dart';
import 'package:flutter_numpad_widget/flutter_numpad_widget.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:vlock/voicePage.dart';


class Pin extends StatefulWidget {
  @override
  _PinState createState() => _PinState();
}

class _PinState extends State<Pin> {
  Size size;
  NumpadController numpadController=NumpadController(format: NumpadFormat.NONE);
  int numero;
  int pin=194578;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numpadController.addListener(() {
      print(numpadController.rawNumber);
      setState(() {
        numero=numpadController.rawNumber;
        if(pin==numero){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>VoicePage()));
        }
      });
    });
  }
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
              width:size.width,
              height: size.height*0.1,

              child:
              Center(
                child:
                Text(numpadController.rawNumber==null?"":numpadController.rawNumber.toString(),style: TextStyle(fontSize: 21,color: Colors.black),),
              )
          ),
          Container(
            child: Numpad(
              height: size.width*0.7,
              width: size.width*0.7,
              controller: numpadController,

            ),
          )
        ],
      ),
    );
  }
}
