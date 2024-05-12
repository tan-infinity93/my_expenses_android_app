
import 'dart:convert';
import 'package:http/http.dart';
import 'dart:async';

class RestAPIAdapter {

  Future<dynamic> getRequest(String url, Map<String, String> headers, Map<String, dynamic> payload) async{
    try {
      final encoding = Encoding.getByName('utf-8');
      final uri = Uri.parse(url);
      Response response = await get(
          uri,
          headers: headers
      );
      int responseCode = response.statusCode;
      String responseBody = response.body;
      print(encoding);
      // print(responseBody);
      return [responseBody, responseCode];
    }
    catch(e) {
      return ['responseBody', 400];
    }
  }

  Future<dynamic> postRequest(String url, Map<String, String> headers, Map<String, dynamic> payload) async {
    try {
      final encoding = Encoding.getByName('utf-8');
      final uri = Uri.parse(url);
      Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(payload),
        encoding: encoding,
      );
      int responseCode = response.statusCode;
      String responseBody = response.body;
      // print(responseBody);
      return [responseBody, responseCode];
    }
    catch(e) {
      return ['responseBody', 400];
    }
  }
}