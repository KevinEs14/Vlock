import 'dart:ffi';

import 'package:flutter/material.dart';
class VoicePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VoicePageState();
  }

}
class _VoicePageState extends State<VoicePage> {
  Size size;
  double tamMic=0.3;
  int dir=1;
  Color _color;

  @override
  initState(){
    super.initState();
    hilo();
  }
  cambiarTam(){

    setState(() {
      tamMic+=0.0015*dir;
      if(tamMic>=0.45){
        dir=-1;
        _color=Colors.red.withOpacity(0.1);
      }
      else{
        if(tamMic<=0.3){
          dir=1;
          _color=Colors.red.withOpacity(0.9);
        }
      }
    });
    hilo();
  }
  hilo()async{
    await Future.delayed(Duration(milliseconds: 1));
    cambiarTam();
  }
  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    return Scaffold(
        body:Column(
          children: [
            SizedBox(height: size.height*0.3,),
            Center(child: Text("Presione para escuchar el comando.",style: TextStyle(color: Colors.black),)),
            Expanded(
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                      width: size.width,
                      height: size.height*0.6,

                      child: Center(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          width: size.width*tamMic*0.8,
                          height: size.width*tamMic*0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  size.width*0.5),
                              border: Border.all(color: Colors.red.withOpacity(((tamMic-0.3)/0.15>1?1:(tamMic-0.3)/0.15<0?0:(tamMic-0.3)/0.15)*0.2))
                          ),
                        ),
                      ),
                    ),
                      Container(
                        width: size.width,
                        height: size.height*0.6,
                        
                        child: Center(
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 1),
                            width: size.width*tamMic,
                            height: size.width*tamMic,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    size.width*0.5),
                                border: Border.all(color: Colors.red.withOpacity((tamMic-0.3)/0.15>1?1:(tamMic-0.3)/0.15<0?0:(tamMic-0.3)/0.15))
                            ),
                          ),
                        ),
                      ),

                      //Image(image: AssetImage("assets/images/voiceButton.jpg"),),
                      Container(
                        width: size.width,
                        height: size.height*0.6,
                        child: Icon(Icons.mic_rounded,size: size.width*0.2,color: Color(0xff99091A)),
                      )
                    ],
                  ),
                )
            ),
          ],
        ),
    );
  }
}
