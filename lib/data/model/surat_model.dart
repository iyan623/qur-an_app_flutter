import 'dart:convert';

Surat suratFromJson(String str) => Surat.fromJson(json.decode(str));

String suratToJson(Surat data) => json.encode(data.toJson());

class Surat {
  final int? nomor;
  final String? nama;
  final String? namaLatin;
  final int? jumlahAyat;
  final String? tempatTurun;
  final String? arti;
  final String? deskripsi;
  final Map<String, String>? audioFull;

  Surat({
    this.nomor,
    this.nama,
    this.namaLatin,
    this.jumlahAyat,
    this.tempatTurun,
    this.arti,
    this.deskripsi,
    this.audioFull,
  });

  factory Surat.fromJson(Map<String, dynamic> json) => Surat(
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["namaLatin"],
        jumlahAyat: json["jumlahAyat"],
        tempatTurun: json["tempatTurun"],
        arti: json["arti"],
        deskripsi: json["deskripsi"],
        audioFull: Map.from(json["audioFull"]!)
            .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "namaLatin": namaLatin,
        "jumlahAyat": jumlahAyat,
        "tempatTurun": tempatTurun,
        "arti": arti,
        "deskripsi": deskripsi,
        "audioFull":
            Map.from(audioFull!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
