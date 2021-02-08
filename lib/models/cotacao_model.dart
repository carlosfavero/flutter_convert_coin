// To parse this JSON data, do
//
//     final cotacaoModel = cotacaoModelFromJson(jsonString);

import 'dart:convert';

Map<String, CotacaoModel> cotacaoModelFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, CotacaoModel>(k, CotacaoModel.fromJson(v)));

String cotacaoModelToJson(Map<String, CotacaoModel> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class CotacaoModel {
    CotacaoModel({
        this.code,
        this.codein,
        this.name,
        this.high,
        this.low,
        this.varBid,
        this.pctChange,
        this.bid,
        this.ask,
        this.timestamp,
        this.createDate,
    });

    String code;
    Codein codein;
    String name;
    String high;
    String low;
    String varBid;
    String pctChange;
    String bid;
    String ask;
    String timestamp;
    DateTime createDate;

    factory CotacaoModel.fromJson(Map<String, dynamic> json) => CotacaoModel(
        code: json["code"],
        codein: codeinValues.map[json["codein"]],
        name: json["name"],
        high: json["high"],
        low: json["low"],
        varBid: json["varBid"],
        pctChange: json["pctChange"],
        bid: json["bid"],
        ask: json["ask"],
        timestamp: json["timestamp"],
        createDate: DateTime.parse(json["create_date"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "codein": codeinValues.reverse[codein],
        "name": name,
        "high": high,
        "low": low,
        "varBid": varBid,
        "pctChange": pctChange,
        "bid": bid,
        "ask": ask,
        "timestamp": timestamp,
        "create_date": createDate.toIso8601String(),
    };
}

enum Codein { BRL, BRLT }

final codeinValues = EnumValues({
    "BRL": Codein.BRL,
    "BRLT": Codein.BRLT
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
