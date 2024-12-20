import 'dart:convert';

AyatModel ayatModelFromJson(String str) => AyatModel.fromJson(json.decode(str));

String ayatModelToJson(AyatModel data) => json.encode(data.toJson());

class AyatModel {
  final int? nomorAyat;
  final String? teksArab;
  final String? teksLatin;
  final String? teksIndonesia;
  final Map<String, String>? audio;

  AyatModel({
    this.nomorAyat,
    this.teksArab,
    this.teksLatin,
    this.teksIndonesia,
    this.audio,
  });

  factory AyatModel.fromJson(Map<String, dynamic> json) => AyatModel(
        nomorAyat: json["nomorAyat"],
        teksArab: json["teksArab"],
        teksLatin: json["teksLatin"],
        teksIndonesia: json["teksIndonesia"],
        audio: Map.from(json["audio"]!)
            .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "nomorAyat": nomorAyat,
        "teksArab": teksArab,
        "teksLatin": teksLatin,
        "teksIndonesia": teksIndonesia,
        "audio":
            Map.from(audio!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
