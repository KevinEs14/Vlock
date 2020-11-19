import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:vlock/voicePage.dart';

class LoginPage extends StatelessWidget {
  Size size;
  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: size.height*0.4,
                width: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/fondo4.jpg'),
                    fit: BoxFit.fill
                  )
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      top: 0,
                        child: Container(
                          width: 80,
                          height: 180,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/light-1.png'),
                            )
                          ),
                        ),
                    ),
                    Positioned(
                      left: 140,
                      top: 0,
                      child: Container(
                        width: 80,
                        height: 120,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/light-2.png'),
                            )
                        ),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      child: Container(
                        width: 80,
                        height: 140,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/clock.png'),
                            )
                        ),
                      ),
                    ),
                    Positioned(
                        child: Container(
                          margin: EdgeInsets.only(top: size.height*0.08),
                          child: Center(
                            child: Text("Vlock",style: TextStyle(color: Colors.white,fontSize: size.height*0.08,fontWeight: FontWeight.bold),),
                          ),
                        )
                    )
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Container(
                      height: 70,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              blurRadius: 20,
                              offset: Offset(0,10),
                            )
                          ]
                      ),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          // border: Border(bottom: BorderSide(color: Colors.grey))
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Nombre de usuario",
                              hintStyle: TextStyle(color: Colors.grey)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      height: 70,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              blurRadius: 20,
                              offset: Offset(0,10),
                            )
                          ]
                      ),
                      child: Container(
                        // height: 60,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          // border: Border(bottom: BorderSide(color: Colors.grey))
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>VoicePage()));
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blueAccent,
                              Colors.redAccent
                            ]
                          ),
                        ),
                        child: Center(child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                        ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
