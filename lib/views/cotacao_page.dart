import 'package:convertCoin/models/cotacao_model.dart';
import 'package:convertCoin/services/cotacao_services.dart';
import 'package:flutter/material.dart';

class CotacaoPage extends StatefulWidget {
  @override
  _CotacaoPageState createState() => _CotacaoPageState();
}

class _CotacaoPageState extends State<CotacaoPage> {
  List<CotacaoModel> cotacao = List<CotacaoModel>();
  CotacaoService cotacaoService = CotacaoService();      

  @override
  void initState() {
    super.initState();
    getCotacao();
  }

  Future<void> getCotacao() async {
    cotacao = await cotacaoService.getCotacao();  
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cotação'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh), 
            onPressed: () {
              cotacao.clear();
              setState(() { });
              getCotacao();
            },
          ),
        ],
      ),
      body: cotacao.length ==0 ? 
        Center(child: 
          CircularProgressIndicator(
            //backgroundColor: Colors.amber,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber)
          )
        ) : 
        ListView.builder(
          itemCount: cotacao.length,
          itemBuilder: (context, index) => buildItem(context, index)
        ),
    );
  }

  Widget buildItem(BuildContext ctxt, int index) {
    return ListTile(
      title: Text(
        cotacao[index].code, 
        style: TextStyle(
          color: Colors.amber,
        )
      ),
      subtitle: Text(
        cotacao[index].name, 
        style: TextStyle(
          color: Colors.white,
        )
      ),
      trailing: Text(
        cotacao[index].ask,
        style: TextStyle(
          fontSize: 20,
          color: Colors.amber,
        )
      ),
    );
  }
}