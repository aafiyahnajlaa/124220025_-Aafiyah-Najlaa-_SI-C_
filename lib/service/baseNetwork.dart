import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseNetwork {
  static final String baseUrl = "https://restaurant-api.dicoding.dev/list";

  static Future<List<dynamic>> getData(String partUrl) async {
    try {
      //buat request ke server
      final response = await http.get(Uri.parse(baseUrl + partUrl));

      // kalo ada respon, kita olah
      if (response.body.isNotEmpty) {
        print(response.body);
        return json.decode(response.body);
      } else {
        print("response kosong");
        return[{
          "success" : false,
          "message" : "gatau :)"
        }];
      }
    } catch (e) {
      print("error saat fetch  : $e");
      return[{
        "success" : false,
        "message" : "gatau :)"
      }];
    }
  }
}