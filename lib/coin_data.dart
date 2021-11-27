import 'dart:convert';
import 'package:bitcoin_ticker/price_screen.dart';
import 'package:http/http.dart' as http;

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
  'ZAR',
  'NGN'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiKey = '458AB2DE-79C5-4E94-9FB2-256D20537749';
const CoinURL = 'https://rest.coinapi.io/v1/exchangerate';


class CoinData {
  PriceScreen priceScreen = PriceScreen();

  Future getCoinData(String selectedCurrency)async{
   Map<String, String> cryptoPrices = {};
   for(String crypto in cryptoList) {
     var url = '$CoinURL/$crypto/$selectedCurrency?apikey=$apiKey';
     http.Response response = await http.get(url);

     if (response.statusCode == 200) {
       var decodedData = jsonDecode(response.body);
       double lastPrice = decodedData['rate'];
       cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
     } else {
       print(response.statusCode);
       throw 'Problem with the get request';
     }
   }
   return cryptoPrices;
  }
}
