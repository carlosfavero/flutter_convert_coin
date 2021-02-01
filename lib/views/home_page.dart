import 'package:convertCoin/controllers/home_controller.dart';
import 'package:convertCoin/views/components/currency_row.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController toText = TextEditingController();
  final TextEditingController fromText = TextEditingController();
  HomeController homeController;
  
  @override
  void initState(){
    super.initState();
    homeController = HomeController(toText: toText, fromText: fromText);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [ 
          Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 40,),
              GestureDetector(
                onTap: (){
                  convert(context);
                },
                child: Image.asset(
                  'assets/images/exchange.png',
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(height: 40,),
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
              SizedBox(height: 20,),
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
              SizedBox(height: 40,),
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
      )
    );
  }

  void convert(BuildContext context) {
    homeController.convert();
    FocusScope.of(context).unfocus();
  }
}