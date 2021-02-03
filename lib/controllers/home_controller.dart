import 'package:convertCoin/models/currency_model.dart';
import 'package:flutter/cupertino.dart';

class HomeController {
  List<CurrencyModel> currencies;

  final TextEditingController toText;
  final TextEditingController fromText;

  CurrencyModel toCurrency;
  CurrencyModel fromCurrency;

  HomeController({this.toText, this.fromText}) {
    currencies = CurrencyModel.getCurremcies();
    toCurrency = currencies[0];
    fromCurrency = currencies[1];
  }

  void convert() {
    String text = toText.text;
    double value = double.tryParse(text.replaceAll(',', '.')) ?? 1.0;
    double returnValue = 0;

    if(fromCurrency.name == 'Real'){
      returnValue = value * toCurrency.real;
    } if(fromCurrency.name == 'Dólar'){
      returnValue = value * toCurrency.dolar;
    } if(fromCurrency.name == 'Euro'){
      returnValue = value * toCurrency.euro;
    } if(fromCurrency.name == 'Bitcoin'){
      returnValue = value * toCurrency.bitcoin;
    }

    toText.text = value.toStringAsFixed(toCurrency.decimals).replaceAll('.', ',');
    fromText.text = returnValue.toStringAsFixed(fromCurrency.decimals).replaceAll('.', ',');

  }

}