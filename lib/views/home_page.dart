import 'package:convertCoin/controllers/home_controller.dart';
import 'package:convertCoin/database/currency_helper.dart';
import 'package:convertCoin/models/currency_info.dart';
import 'package:convertCoin/views/components/currency_row.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CurrencyHelper _currencyHelper = CurrencyHelper();
  Future<List<CurrencyInfo>> _currency;
  
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
        children: [
          Flexible(
            flex: 3,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 18),
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
                          width: 130,
                          height: 130,

                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      CurrencyRow(
                        enabled: true,
                        sufix: homeController.toCurrency.suffix,
                        prefix: homeController.toCurrency.prefix,
                        selectedItem: homeController.toCurrency,
                        controller: toText,
                        items: homeController.currencies,
                        onChanged: (model) {
                          setState(() {
                            homeController.toCurrency = model;
                            //convert(context);
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CurrencyRow(
                        sufix: homeController.fromCurrency.suffix,
                        prefix: homeController.fromCurrency.prefix,
                        enabled: true,
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
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            color: Colors.amber[300],
                            child: Text(
                              'Limpar',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () {
                              toText.clear();
                              fromText.clear();
                            },
                          ),
                          SizedBox(width: 40,),
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
                    ],
                  ),
                ),
              ]
            ),
          ),
          Flexible(
            flex: 1,
            child: FutureBuilder<List<CurrencyInfo>>(
              future: _currency,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: snapshot.data.map<Widget>((currency) {
                      var alarmTime = DateFormat('dd/MM/yyyy hh:mm aa').format(currency.dateTime);
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                        child: Column(
                          children: <Widget>[
                            Row(                            
                              children: [
                                Text(alarmTime),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            currency.toCurrency,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                            currency.toText,
                                            style: TextStyle(
                                              color: Colors.amber,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            currency.fromCurrency,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                            currency.fromText,
                                            style: TextStyle(
                                              color: Colors.amber,
                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(width: 10,),                                
                                        ]
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          FlatButton(
                                            onPressed: () {
                                              onDelete(currency.id);
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.amber,
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                              
                              
                            ]
                          // ),
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
    if(toText.text!=''){
      homeController.convert();
      onSave();
    } else {
      fromText.text = '';
    }
    FocusScope.of(context).unfocus();
  }

  void onSave() {
    var prefixTo = (homeController.toCurrency.prefix!=""?homeController.toCurrency.prefix:"");
    var suffixTo = (homeController.toCurrency.suffix!=""?" "+homeController.toCurrency.suffix:"");
    var prefixFrom = (homeController.fromCurrency.prefix!=""?homeController.fromCurrency.prefix:"");
    var suffixFrom = (homeController.fromCurrency.suffix!=""?homeController.fromCurrency.suffix:"");

    var currencyInfo = CurrencyInfo(
      toCurrency: homeController.toCurrency.name,
      fromCurrency: homeController.fromCurrency.name,
      toText: '$prefixTo${toText.text}$suffixTo',
      fromText: '$prefixFrom${fromText.text}$suffixFrom',
      dateTime: DateTime.now(),
    );    
    _currencyHelper.insertCurrency(currencyInfo);
    loadCurrency();
  }

  void onDelete(int id) {
    _currencyHelper.delete(id);
    loadCurrency();
  }

}
