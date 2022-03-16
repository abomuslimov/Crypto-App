import 'package:http/http.dart' as http;
import 'dart:convert';
import 'price_screen.dart';

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

const coinApiURL = 'https://r<uses-permission android:name="android.permission.INTERNET" />est.coinapi.io/v1/exchangerate';
const apiKey = '6D815C96-05DC-4477-B31B-C8409E5204CE';

class CoinData {

  Future getCoinData(String selectedCurrency) async {
    Map<String,String> cryptoPrices={};

    for(String crypto in cryptoList){
      String requestURL =
          '$coinApiURL/$crypto/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(Uri.parse(requestURL));
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];
        cryptoPrices[crypto]=lastPrice.toStringAsFixed(0);
      } else {
        print('Error code: ${response.statusCode}');
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
