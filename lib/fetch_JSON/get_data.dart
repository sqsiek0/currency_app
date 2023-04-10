import 'package:currency_app/fetch_JSON/model_class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  Future<Currency> fetchData({required String code}) async {
    final response = await http.get(Uri.parse(
        "http://api.nbp.pl/api/exchangerates/rates/a/$code/last/30/?format=json"));

    if (response.statusCode == 200) {
      Future.delayed(const Duration(seconds: 1));
      return Currency.fromJson(json.decode(response.body));
    } else {
      throw Exception("Błąd w załadowaniu z pliku json");
    }
  }
}
