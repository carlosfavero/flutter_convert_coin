import 'package:convertCoin/models/cotacao_model.dart';
import 'package:dio/dio.dart';

class CotacaoService {
  Future getCotacao() async {
    List<CotacaoModel> _list = List<CotacaoModel>();
    Dio dio = Dio();
    final response = await dio.get('https://economia.awesomeapi.com.br/json/all');
    
    
    for (String key in response.data.keys) 
      _list.add(CotacaoModel.fromJson(response.data[key]));
    
    return _list;
  }
}
