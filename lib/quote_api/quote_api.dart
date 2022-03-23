import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frasedeldia/quote/models/models.dart';
class QuoteAPI{
  final String baseUrl = "https://quotes.rest";

  Future<dynamic> getQuote() async{
    String urlMetodo = "$baseUrl/qod";
    print(urlMetodo);
    var response = await http.get(Uri.parse(urlMetodo));
    print(response.statusCode);
    if(response.statusCode == 200){
      print("Respuesta 200:::");
      Quote quote = Quote.fromJson(json.decode(response.body));
      print(quote.quote);
      return quote;
    }else{
      print("Respuesta diferente a 200:::");
      return null;
    }
  }
}