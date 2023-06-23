import 'dart:convert';
import 'dart:developer';
import 'package:currency_exchange/constant/url.dart';
import 'package:currency_exchange/model_class/currency_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<CurrencyModel>> getLatest(String baseCurrency) async {
    List<CurrencyModel> currencyList = [];

    String url = "${BaseUrl}apikey=$apikey&base_currency=$baseCurrency";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body)['data'];
        // Map<String, dynamic> body = json['data'];
        json.forEach((key, value) {
          CurrencyModel currencyModel = CurrencyModel.fromJson(value);
          currencyList.add(currencyModel);
        });
        return currencyList;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }


  Future<List<CurrencyModel>> getExchange(String baseCurrency,String targetCurrency) async {
    List<CurrencyModel> currencyList = [];

    String url = "${BaseUrl}apikey=$apikey&base_currency=$baseCurrency&currencies=$targetCurrency";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        Map<String, dynamic> body = json['data'];
        body.forEach((key, value) {
          CurrencyModel currencyModel = CurrencyModel.fromJson(value);
          currencyList.add(currencyModel);
        });
        return currencyList;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }
}
