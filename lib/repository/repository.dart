
import 'dart:convert';

import 'package:http/http.dart' as http;
cambiarAlarma(int valor)async {
  try{
    var url="http://blynk-cloud.com/1UWiqTpJ2Cv1y7wcqUBn1dXDkpGe90ZX/update/V3?value="+valor.toString();
    final response = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
    );
    print(response.statusCode);
    if(response.statusCode==200){
      return true;
    }
    else{
      return false;
    }
  }
  catch(e){
    print(e);
    return false;
  }
}
Future<int> estadoAlarma()async {
  try{
    var url="http://blynk-cloud.com/1UWiqTpJ2Cv1y7wcqUBn1dXDkpGe90ZX/get/V4";
    final response = await http.get(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var val=jsonDecode(response.body);
    if(response.statusCode==200){
      return int.parse(val[0]);
    }
    else{
      return 2;
    }
  }
  catch(e){
    print(e);
    return 2;
  }
}
determinarComando(String texto)async{
  texto=texto.toLowerCase();
  var abrir=-1;
  switch(texto){
    case "abrir":
      abrir=1;
      break;
    case "abrir puerta":
      abrir=1;
      break;
    case "open the door":
      abrir=1;
      break;
    case "cerrar":
      abrir=2;
      break;
    case "cerrar puerta":
      abrir=2;
      break;
    case "close the door":
      abrir=1;
      break;

  }
  if(abrir!=-1){
    try{
      var url="http://blynk-cloud.com/1UWiqTpJ2Cv1y7wcqUBn1dXDkpGe90ZX/update/V5?value="+abrir.toString();
      final response = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if(response.statusCode==200){
        return true;
      }
      else{
        return false;
      }
    }
    catch(e){
      print(e);
      return false;
    }
  }
  else{return false;}
}