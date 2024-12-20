import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './model/ayat_model.dart';
import './model/surat_model.dart';

Future<List<Surat>> getSuratData() async {
  final response = await http.get(
    Uri.parse('https://equran.id/api/v2/surat'),
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return data['data'].map<Surat>((surat) => Surat.fromJson(surat)).toList();
  } else {
    debugPrint('Failed to load data');
  }

  return [];
}

Future<List<AyatModel>> getAyatData(int nomor) async {
  final response = await http.get(
    Uri.parse('https://equran.id/api/v2/surat/$nomor'),
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);

    return data['data']['ayat']
        .map<AyatModel>((ayat) => AyatModel.fromJson(ayat))
        .toList();
  } else {
    debugPrint('Failed to load data');
  }

  return [];
}
