import 'package:convertCoin/controllers/home_controller.dart';
import 'package:convertCoin/database/currency_helper.dart';
import 'package:convertCoin/models/currency_info.dart';
import 'package:convertCoin/views/components/currency_row.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CurrencyHelper _currencyHelper = CurrencyHelper();
  Future<List<CurrencyInfo>> _currency;
  List<CurrencyInfo> _current;

  final TextEditingController toText = TextEditingController();
  final TextEditingController fromText = TextEditingController();
  HomeController homeController;

  @override
  void initState() {
    super.initState();
    _currencyHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadCurrency();
    });
    homeController = HomeController(toText: toText, fromText: fromText);
  }

  void loadCurrency() async {
    _currency = _currencyHelper.getCurrency();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 3,
            child: ListView(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            convert(context);
                          },
                          child: Image.asset(
                            'assets/images/exchange.png',
                            width: 100,
                            height: 100,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        CurrencyRow(
                          selectedItem: homeController.toCurrency,
                          controller: toText,
                          items: homeController.currencies,
                          onChanged: (model) {
                            setState(() {
                              homeController.toCurrency = model;
                              convert(context);
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CurrencyRow(
                          selectedItem: homeController.fromCurrency,
                          controller: fromText,
                          items: homeController.currencies,
                          onChanged: (model) {
                            setState(() {
                              homeController.fromCurrency = model;
                              convert(context);
                            });
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        RaisedButton(
                          color: Colors.amber[300],
                          child: Text(
                            'Converter',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            convert(context);
                          },
                        ),
                      ],
                    ),
                  ),
              ]
            ),
          ),
          Expanded(
            flex: 1,
            child: FutureBuilder<List<CurrencyInfo>>(
              future: _currency,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _current = snapshot.data;
                  return ListView(
                    children: snapshot.data.map<Widget>((currency) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  currency.toCurrency,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  currency.toText,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  currency.fromCurrency,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  currency.fromText,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                FlatButton(
                                  onPressed: () {
                                    onDelete(currency.id);
                                  },
                                  child: Icon(Icons.delete)
                                ),
                              ]
                            )
                          ]
                        ),
                      );
                    }).toList(),
                  );
                }
                return Text('No data');
              }),
          ),
        ],
      ),
    );
  }

  void convert(BuildContext context) {
    homeController.convert();
    onSave();
    FocusScope.of(context).unfocus();
  }

  void onSave() {
    var currencyInfo = CurrencyInfo(
      toCurrency: homeController.toCurrency.name,
      fromCurrency: homeController.fromCurrency.name,
      toText: toText.text,
      fromText: fromText.text,
    );    
    _currencyHelper.insertCurrency(currencyInfo);
    loadCurrency();
  }

  void onDelete(int id) {
    _currencyHelper.delete(id);
    loadCurrency();
  }

}
