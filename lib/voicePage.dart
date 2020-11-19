import 'package:flutter/material.dart';

class VoicePage extends StatelessWidget {
  Size size;
  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height*0.3,),
            Center(child: Text("Bienvenido, presione para desbloquear con la voz",style: TextStyle(color: Colors.black),)),
            Container(
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Image(image: AssetImage("assets/images/voiceButton.jpg"),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
