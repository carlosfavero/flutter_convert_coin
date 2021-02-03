class CurrencyInfo {
  int id;
  String toCurrency;
  String fromCurrency;
  String toText;
  String fromText;
  DateTime dateTime;

  CurrencyInfo({this.id, this.toCurrency, this.fromCurrency, this.toText, this.fromText, this.dateTime});
  
  factory CurrencyInfo.fromMap(Map<String, dynamic> json) => CurrencyInfo(
        id: json["id"],
        toCurrency: json["tocurrency"],
        fromCurrency: json["fromcurrency"],
        toText: json["totext"],
        fromText: json["fromtext"],
        dateTime: DateTime.parse(json["datetime"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "tocurrency": toCurrency,
        "fromcurrency": fromCurrency,
        "totext": toText,
        "fromtext": fromText,
        "datetime": dateTime.toIso8601String(),
      };

}