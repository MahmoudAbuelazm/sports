class GetPlayersModel {
  GetPlayersModel({
    this.success,
    this.result,
  });
  int? success;
  List<Result>? result;

  GetPlayersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result = List.from(json['result']).map((e) => Result.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['result'] = result!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Result {
  Result({
    this.playerKey,
    this.playerName,
    this.playerNumber,
    this.playerCountry,
    this.playerType,
    this.playerAge,
    this.playerMatchPlayed,
    this.playerGoals,
    this.playerYellowCards,
    this.playerRedCards,
    this.playerMinutes,
    this.playerInjured,
    this.playerSubstituteOut,
    this.playerSubstitutesOnBench,
    this.playerAssists,
    this.playerIsCaptain,
    this.playerShotsTotal,
    this.playerGoalsConceded,
    this.playerFoulsCommited,
    this.playerTackles,
    this.playerBlocks,
    this.playerCrossesTotal,
    this.playerInterceptions,
    this.playerClearances,
    this.playerDispossesed,
    this.playerSaves,
    this.playerInsideBoxSaves,
    this.playerDuelsTotal,
    this.playerDuelsWon,
    this.playerDribbleAttempts,
    this.playerDribbleSucc,
    this.playerPenComm,
    this.playerPenWon,
    this.playerPenScored,
    this.playerPenMissed,
    this.playerPasses,
    this.playerPassesAccuracy,
    this.playerKeyPasses,
    this.playerWoordworks,
    this.playerRating,
    this.teamName,
    this.teamKey,
    this.playerImage,
  });
  int? playerKey;
  String? playerName;
  String? playerNumber;
  String? playerCountry;
  String? playerType;
  String? playerAge;
  String? playerMatchPlayed;
  String? playerGoals;
  String? playerYellowCards;
  String? playerRedCards;
  String? playerMinutes;
  String? playerInjured;
  String? playerSubstituteOut;
  String? playerSubstitutesOnBench;
  String? playerAssists;
  String? playerIsCaptain;
  String? playerShotsTotal;
  String? playerGoalsConceded;
  String? playerFoulsCommited;
  String? playerTackles;
  String? playerBlocks;
  String? playerCrossesTotal;
  String? playerInterceptions;
  String? playerClearances;
  String? playerDispossesed;
  String? playerSaves;
  String? playerInsideBoxSaves;
  String? playerDuelsTotal;
  String? playerDuelsWon;
  String? playerDribbleAttempts;
  String? playerDribbleSucc;
  String? playerPenComm;
  String? playerPenWon;
  String? playerPenScored;
  String? playerPenMissed;
  String? playerPasses;
  String? playerPassesAccuracy;
  String? playerKeyPasses;
  String? playerWoordworks;
  String? playerRating;
  String? teamName;
  int? teamKey;
  String? playerImage;

  Result.fromJson(Map<String, dynamic> json) {
    playerKey = json['player_key'];
    playerName = json['player_name'];
    playerNumber = json['player_number'];
    playerCountry = json['player_country'];
    playerType = json['player_type'];
    playerAge = json['player_age'];
    playerMatchPlayed = json['player_match_played'];
    playerGoals = json['player_goals'];
    playerYellowCards = json['player_yellow_cards'];
    playerRedCards = json['player_red_cards'];
    playerMinutes = json['player_minutes'];
    playerInjured = json['player_injured'];
    playerSubstituteOut = json['player_substitute_out'];
    playerSubstitutesOnBench = json['player_substitutes_on_bench'];
    playerAssists = json['player_assists'];
    playerIsCaptain = json['player_is_captain'];
    playerShotsTotal = json['player_shots_total'];
    playerGoalsConceded = json['player_goals_conceded'];
    playerFoulsCommited = json['player_fouls_commited'];
    playerTackles = json['player_tackles'];
    playerBlocks = json['player_blocks'];
    playerCrossesTotal = json['player_crosses_total'];
    playerInterceptions = json['player_interceptions'];
    playerClearances = json['player_clearances'];
    playerDispossesed = json['player_dispossesed'];
    playerSaves = json['player_saves'];
    playerInsideBoxSaves = json['player_inside_box_saves'];
    playerDuelsTotal = json['player_duels_total'];
    playerDuelsWon = json['player_duels_won'];
    playerDribbleAttempts = json['player_dribble_attempts'];
    playerDribbleSucc = json['player_dribble_succ'];
    playerPenComm = json['player_pen_comm'];
    playerPenWon = json['player_pen_won'];
    playerPenScored = json['player_pen_scored'];
    playerPenMissed = json['player_pen_missed'];
    playerPasses = json['player_passes'];
    playerPassesAccuracy = json['player_passes_accuracy'];
    playerKeyPasses = json['player_key_passes'];
    playerWoordworks = json['player_woordworks'];
    playerRating = json['player_rating'];
    teamName = json['team_name'];
    teamKey = json['team_key'];
    playerImage = json['player_image'] ??
        "https://thumbs.dreamstime.com/b/mo-salah-professional-footballer-vector-image-bandung-indonesia-march-mo-salah-professional-footballer-vector-image-242630646.jpg";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['player_key'] = playerKey;
    _data['player_name'] = playerName;
    _data['player_number'] = playerNumber;
    _data['player_country'] = playerCountry;
    _data['player_type'] = playerType;
    _data['player_age'] = playerAge;
    _data['player_match_played'] = playerMatchPlayed;
    _data['player_goals'] = playerGoals;
    _data['player_yellow_cards'] = playerYellowCards;
    _data['player_red_cards'] = playerRedCards;
    _data['player_minutes'] = playerMinutes;
    _data['player_injured'] = playerInjured;
    _data['player_substitute_out'] = playerSubstituteOut;
    _data['player_substitutes_on_bench'] = playerSubstitutesOnBench;
    _data['player_assists'] = playerAssists;
    _data['player_is_captain'] = playerIsCaptain;
    _data['player_shots_total'] = playerShotsTotal;
    _data['player_goals_conceded'] = playerGoalsConceded;
    _data['player_fouls_commited'] = playerFoulsCommited;
    _data['player_tackles'] = playerTackles;
    _data['player_blocks'] = playerBlocks;
    _data['player_crosses_total'] = playerCrossesTotal;
    _data['player_interceptions'] = playerInterceptions;
    _data['player_clearances'] = playerClearances;
    _data['player_dispossesed'] = playerDispossesed;
    _data['player_saves'] = playerSaves;
    _data['player_inside_box_saves'] = playerInsideBoxSaves;
    _data['player_duels_total'] = playerDuelsTotal;
    _data['player_duels_won'] = playerDuelsWon;
    _data['player_dribble_attempts'] = playerDribbleAttempts;
    _data['player_dribble_succ'] = playerDribbleSucc;
    _data['player_pen_comm'] = playerPenComm;
    _data['player_pen_won'] = playerPenWon;
    _data['player_pen_scored'] = playerPenScored;
    _data['player_pen_missed'] = playerPenMissed;
    _data['player_passes'] = playerPasses;
    _data['player_passes_accuracy'] = playerPassesAccuracy;
    _data['player_key_passes'] = playerKeyPasses;
    _data['player_woordworks'] = playerWoordworks;
    _data['player_rating'] = playerRating;
    _data['team_name'] = teamName;
    _data['team_key'] = teamKey;
    _data['player_image'] = playerImage;
    return _data;
  }
}