import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:vlock/voicePage.dart';
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }

}
class _LoginPageState extends State<LoginPage>{
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }
  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }
  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticateWithBiometrics(
        androidAuthStrings: AndroidAuthMessages(signInTitle: "Desbloqueo con huella",
        fingerprintHint: "",cancelButton: "Utilizar contraseña"),
          localizedReason: 'Utiliza la huella para despbloquear la aplicacion.',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) {
      print("asdfsadf");
      return;}

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }
  mostrarHuella()async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _authenticate();
      if(_authorized=="Authorized"){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>VoicePage()));
      }
      /*showDialog(context: context,
          builder: (BuildContext context){
            return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: Container(
                width: size.width*0.8,
                height: size.width*0.8,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/fondo_huella.jpg"),
                      fit: BoxFit.fill
                    )
                  ),
                  child: Stack(
                    children: [
                      Container(
                        height: size.width*0.2,
                        child:
                          Center(
                            child:
                            Text("Inicio con huella"+_authorized,textAlign: TextAlign.center,style: TextStyle(fontSize: size.width*0.06,color: Colors.white),),
                          )
                      ),
                     Container(
                       child: Center(
                         child:  AnimatedContainer(duration: Duration(milliseconds: 500),
                           child: Icon(
                             Icons.fingerprint_sharp,
                             size: size.width*0.25,
                             color: Color(0xff99091A),
                           ),
                         ),
                       ),
                     ),
                      Container(
                        margin: EdgeInsets.only(top: size.width*0.6),
                        child:
                        Center(
                          child: RaisedButton(
                            elevation: 0,
                            child: Text("Ingresar con correo y contraseña",style:TextStyle(fontSize:size.width*0.04,color: Color(0xff095C99))),
                            color: Colors.transparent,
                            onPressed: (){
                                Navigator.pop(context);
                            },
                          ),
                        )
                      )
                    ],
                  ),
              ),
            );
          });*/
    });
    }

  @override
  initState(){
    super.initState();
    mostrarHuella();
  }
  Size size;
  TextEditingController nombre=TextEditingController();
  TextEditingController password=TextEditingController();
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
              Container(
                padding: EdgeInsets.all(30.0),
                height: size.height*0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    Container(
                      height: 60,
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
                          controller: nombre,
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
                      height: 60,
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
                          controller: password,
                          obscureText: true,
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
                        if(password.text.toString()=="1234abc"&&nombre.text.toString()=="admin"){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VoicePage()));
                        }
                        else{
                          Fluttertoast.showToast(msg: "Usuario o contraseña incorrectos",backgroundColor: Colors.black.withOpacity(0.5));
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: size.width*0.2,right: size.width*0.2),
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff121212),Color(0xff99091A),
                              Color(0xff121212)]
                          ),
                        ),
                        child: Center(child: Text("Login",style: TextStyle(fontSize:size.width*0.05,color: Colors.white,fontWeight: FontWeight.bold),)),
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
