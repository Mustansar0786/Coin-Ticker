// ignore_for_file: unnecessary_const

import 'package:coin_ticker/networking.dart';
import 'package:flutter/material.dart';

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
];
const List<String> cryptoList = [
  "BTC",
  "ETH",
  "LTC",
];

kToast(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
    ),
  ));
}

// enum KCoin { BTC, ETH, LTC }

class CoinData {
  Future<double> getrate(String selectedCurrency, String coin) async {
    Networking networking = Networking(
        'https://rest.coinapi.io/v1/exchangerate/$coin/$selectedCurrency?apikey=E4CC7807-3430-41B6-A6DD-083F48A48F31 ');

    dynamic data = await networking.getdata();
    var lastPrice = data['rate'];
    return lastPrice;
  }
}
