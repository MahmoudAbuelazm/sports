import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sports_app/Data/Models/data/leagues.dart';
import 'package:sports_app/Data/constants/constants.dart';

class LeaguesRepo {
  Future<Leagues?> getAllLeagues( countryId) async {
    try {
      http.Response response = await http.get(Uri.parse(
          "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=$apiKey&countryId=${countryId}"));

      Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        Leagues leagues = Leagues.fromJson(data);
        return leagues;
      } else {
        // ignore: avoid_print
        print("request failed");
        return null;
      }
    } catch (error) {
      debugPrint("error : $error");
      return null;
    }
  }
}
