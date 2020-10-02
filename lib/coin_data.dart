import 'package:http/http.dart' as http;
import 'dart:convert';
import 'secret_settings.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String service = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future getCoinData({String cryptoCurrency, String currency}) async {
    String url = '$service/$cryptoCurrency/$currency?apikey=$apiKey';

    try {
      http.Response response = await http.get(url);
      var decodedData = jsonDecode(response.body);
      return decodedData['rate'];
    } catch (e) {
      return Future;
    }
  }
}
