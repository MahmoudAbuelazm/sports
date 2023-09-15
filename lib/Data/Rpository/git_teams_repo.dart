import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sports_app/Data/Models/data/get_teams_model.dart';



var league_id;
var temp2;
var team_name;
String apiKey =
    "ba8cce3a55c7eda219fca0330f1ac53671a427aea4542ae118bd628d6b494a67";

class GetTeamsRepo {
  Future<GetTeamsModel?> getTeams() async {
    temp2 = league_id;
    try {
      var teamsresponse = await http.get(
        Uri.parse(
            "https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=${league_id} ?? ""}&APIkey=ba8cce3a55c7eda219fca0330f1ac53671a427aea4542ae118bd628d6b494a67"),
      );

      var decodedResponse = jsonDecode(teamsresponse.body);

      if (teamsresponse.statusCode == 200) {
        GetTeamsModel myResponse = GetTeamsModel.fromJson(decodedResponse);

        print("heloooo ${myResponse}");

        return myResponse;
      } else {
        print("faaaalse");

        return null;
      }
    } catch (error) {
      print("faaaalse ${error}");

      return null;
    }
  }
}

