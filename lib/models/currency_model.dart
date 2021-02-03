class CurrencyModel {
  final String name;
  final int decimals;
  final String prefix;
  final String suffix;
  final double real;
  final double dolar;
  final double euro;
  final double bitcoin;

  CurrencyModel({this.name, this.decimals, this.prefix, this.suffix, this.real, this.dolar, this.euro, this.bitcoin});

  static List<CurrencyModel> getCurremcies() {
    return <CurrencyModel> [
      CurrencyModel(name: 'Real', decimals: 2, prefix: 'R\$ ', suffix: '', real: 1.0, dolar: 0.18, euro: 0.15, bitcoin: 0.000016),
      CurrencyModel(name: 'Dólar', decimals: 2, prefix: '', suffix: ' \$', real: 5.45, dolar: 1.0, euro: 0.85, bitcoin: 0.000088),
      CurrencyModel(name: 'Euro', decimals: 2, prefix: '', suffix: ' \$', real: 6.62, dolar: 1.17, euro: 1.0, bitcoin: 0.00010),
      CurrencyModel(name: 'Bitcoin', decimals: 8, prefix: '', suffix: '\$B', real: 180000.00, dolar: 30000.00, euro: 10000.0, bitcoin: 1.0),
    ];
  }
  
}