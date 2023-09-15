import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:sports_app/Data/Models/get_topScorer_model.dart';

var league_id;
var temp2;
var team_name;
String apiKey =
    "ba8cce3a55c7eda219fca0330f1ac53671a427aea4542ae118bd628d6b494a67";



class GetTopScorerRepo {
  Future<GetTopScorerModel?> getGoals() async {
    try {
      var goalsresponse = await http.get(
        Uri.parse(
            "https://apiv2.allsportsapi.com/football/?&met=Topscorers&leagueId=${league_id}&APIkey=ba8cce3a55c7eda219fca0330f1ac53671a427aea4542ae118bd628d6b494a67"),
      );

      var decodedResponse = jsonDecode(goalsresponse.body);

      if (goalsresponse.statusCode == 200) {
        GetTopScorerModel response = GetTopScorerModel.fromJson(decodedResponse);

        return response;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}