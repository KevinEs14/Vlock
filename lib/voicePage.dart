import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:async';
import 'dart:math';
import 'repository/repository.dart';
class VoicePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VoicePageState();
  }

}
class _VoicePageState extends State<VoicePage> {
  //Color colEstado=Color(0xff99091A);
  Color colEstado=Color(0xff086A09);
  bool alaEstado=false;
  bool alaActivado=true;
  Size size;
  double tamMic=0.3;
  int dir=1;
  bool escuchar=false;
  Color _color;
  final SpeechToText speech = SpeechToText();
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String _currentLocaleId = "";
  List<LocaleName> _localeNames = [];
  Future<void> initSpeechState() async {
  bool hasSpeech = await speech.initialize(
  onError: errorListener, onStatus: statusListener);
  if (hasSpeech) {
  _localeNames = await speech.locales();

  var systemLocale = await speech.systemLocale();
  _currentLocaleId = systemLocale.localeId;
  }

  if (!mounted) return;

  setState(() {
  _hasSpeech = hasSpeech;
  });
  }
  double tamCard=2;
  double posCard=2;
  @override
  initState(){
    super.initState();
    hilo();
    hiloEstadoAlarma();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      tamCard=MediaQuery.of(this.context).size.height*0.1;
      posCard=MediaQuery.of(this.context).size.height*0.1;
    });
  }
  cambiarTam(){
    if(lastStatus=="listening") {
      setState(() {
        tamMic += 0.0015 * dir;
        if (tamMic >= 0.45) {
          dir = -1;
          _color = colEstado.withOpacity(0.1);
        }
        else {
          if (tamMic <= 0.3) {
            dir = 1;
            _color = colEstado.withOpacity(0.9);
          }
        }
      });

      hilo();
    }else{
      setState(() {
        tamMic=0.3;
      });
    }

  }
  hilo()async{
    await Future.delayed(Duration(milliseconds: 1));
    cambiarTam();
  }
  void startListening() {
    lastWords = "";
    lastError = "";
    speech.listen(

        onResult: resultListener,
        listenFor: Duration(seconds: 10),
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result)async {

    setState((){
      if(lastStatus!="listening"){
        _moverMicrofono(-1);

      }
      lastWords = "${result.recognizedWords} - ${result.finalResult}";

    });

    if(lastStatus!="listening"){
    await determinarComando(result.recognizedWords);
    }
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    // print("Received error status: $error, listening: ${speech.isListening}");
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  void statusListener(String status) {
    // print(
    // "Received listener status: $status, listening: ${speech.isListening}");
    setState(() {
      lastStatus = "$status";
    });
  }

  _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
    print(selectedVal);
  }
  _moverMicrofono(tipo)async {
    var tamMov=0.07*tipo;
    var rapidez=0.5;
    var mover1=true;
    var mover2=true;
    if(posCard<=size.height/2-tamCard/2){
      if(posCard-size.height/2-tamCard/2<=10){
        rapidez=2;
      }
      else if(posCard-size.height/2-tamCard/2<=20){
        rapidez=1;
      }
    }
    setState(() {
      if(tipo==1){
        if(tamCard<=size.width*0.4) {
          tamCard += tamMov*rapidez;
        }
        else mover1=false;
        if(posCard<=size.height/2-tamCard/2){
          posCard+=tamMov*rapidez;
        }
        else mover2=false;
      }
      else{
        if(tamCard>=size.height*0.1) {
          tamCard += tamMov*rapidez;
        }
        else mover1=false;
        if(posCard>=size.height*0.1){
          posCard+=tamMov*rapidez;
        }
        else mover2=false;
      }
    });
    if(mover1&&mover2){
      await Future.delayed(Duration(microseconds: 30));
      _moverMicrofono(tipo);
    }
    else{
      if(tipo==1){

        print("llama");
        await initSpeechState();
        startListening();
        hilo();
      }
    }
  }

  hiloEstadoAlarma()async{
    await Future.delayed(Duration(seconds: 1));
    int estado=await estadoAlarma();
    setState(() {
      if(estado==0){
        alaEstado=false;
        colEstado=Color(0xff086A09);
      }
      else if(estado==1){
        alaEstado=true;
        colEstado=Color(0xff99091A);
      }
    });
    hiloEstadoAlarma();
  }
  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    return Scaffold(
        body:Stack(
          children: [
            Container(
              height: size.height*0.8,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    Material(
                      elevation:2,
                borderRadius: BorderRadius.circular(size.height*0.05),
                      child: Container(
                        height: size.height*0.3,
                        width: size.width*0.8,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0),
                          borderRadius: BorderRadius.circular(size.height*0.05),
                          border: Border.all(color:colEstado.withOpacity(0.7))
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                              Text("Estado Caja Fuerte",style:TextStyle(color: Colors.black,fontSize: 21,fontWeight: FontWeight.w400)),
                            Icon(alaEstado?Icons.warning:Icons.done,color: colEstado.withOpacity(0.7),size: size.height*0.1,),
                            Text(alaEstado?"Alguien esta cerca de la caja":"Correcto",style:TextStyle(color: colEstado.withOpacity(0.7),fontSize: 21)),
                          ],
                        ),
                      ),
                    ),MaterialButton(
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical:size.height*0.02,horizontal: size.height*0.04),

                        color: alaActivado?Colors.black.withOpacity(0.6):Colors.black.withOpacity(0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.black.withOpacity(0.7))),
                        onPressed: ()async{

                          if(alaActivado){
                            bool res=await cambiarAlarma(2);
                            if(res){
                              setState(() {
                                alaActivado=!alaActivado;
                              });
                            }
                          }
                          else{
                            bool res=await cambiarAlarma(1);
                            if(res){
                              setState(() {
                                alaActivado=!alaActivado;
                              });
                            }
                          }
                        },
                        child: Text(alaActivado?"Desactivar Alarma":"Activar Alarma",style: TextStyle(color: alaActivado?Colors.white:Colors.black),),
                      ),

                ],
              ),
            ),
            Align(
              alignment: Alignment(0,1),
              child: Container(
                width: size.width,
                height: size.height*0.15,
                decoration: BoxDecoration(
                  color: colEstado.withOpacity(0.7),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(size.width*0.25),topRight: Radius.circular(size.width*0.25))
                ),
                child: Center(
                  child: Text("Escuchar",style: TextStyle(color: Colors.white,fontSize: 21),),
                ),
              )
            ),tamCard<=size.width*0.4?Container():AnimatedContainer(
              duration: Duration(microseconds: 1),
              width: size.width,
                height: size.height,
                color: Colors.black.withOpacity(((size.width*0.4)/tamCard)*0.6),
              ),
                Positioned(
                    bottom: posCard,
                    left: size.width/2-tamCard/2,
                    child: microfono(tamCard, tamCard)
                ),
                tamCard<=size.width*0.4?Container():
                Positioned(
                  top: size.height/2-tamCard,
                  child: Container(
                    padding: EdgeInsets.all(size.width*0.05),
                  width: size.width,
                  color:Colors.black.withOpacity(0.3),
                  child: Column(
                    children: [
                      Text(lastStatus=="listening"?"Escuchando...":"Descifrando Comando...",textAlign: TextAlign.center,style:TextStyle(color: lastStatus=="listening"?Colors.white:Colors.lightGreen,fontSize: 21)),
                      Divider(
                        height: size.height*0.03,
                        color: Colors.white.withOpacity(0),
                      ),
                      Text(lastWords.split("-")[0],textAlign: TextAlign.center,style:TextStyle(color: Colors.white,fontSize: 21)),],
                  )
                )),
          ],
        ),
    );

  }
 Widget microfono (width,heigth){
   return GestureDetector(
       onTap: ()async {
         await _moverMicrofono(1);

       },
       child: Material(
         elevation: 5,
         borderRadius:BorderRadius.circular(width),
         child: Container(
           width: width,
           height: heigth,
           decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(width)

           ),
           child: Center(
             child: AnimatedContainer(
                 duration: Duration(milliseconds: 1),
                 width: width*2*tamMic*0.8,
                 height: heigth*2*tamMic*0.8,
                 decoration: BoxDecoration(
                     color: Colors.transparent,
                     borderRadius: BorderRadius.circular(
                         width),
                     border: Border.all(color: colEstado.withOpacity(((tamMic-0.3)/0.15>1?1:(tamMic-0.3)/0.15<0?0:(tamMic-0.3)/0.15)*0.5))
                 ),
                 child:
                 Center(
                   child: AnimatedContainer(
                     duration: Duration(milliseconds: 100),
                     width: width*2*tamMic*0.6,
                     height:heigth*2*tamMic*0.6,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(
                             heigth),
                         border: Border.all(color: colEstado.withOpacity(((tamMic-0.3)/0.15>1?1:(tamMic-0.3)/0.15<0?0:(tamMic-0.3)/0.15)*0.2))
                     ),
                     child:Center(
                       child: Icon(Icons.mic_rounded,size: width*0.3,color: colEstado),
                     ),
                   ),
                 )
             ),
           ),
         ),
       )
   );
 }

}
