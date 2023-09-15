class Leagues {
  Leagues({
    required this.success,
    required this.result,
  });
  late final int success;
  late final List<Result> result;
  
  Leagues.fromJson(Map<String, dynamic> json){
    success = json['success'];
    result = List.from(json['result']).map((e)=>Result.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['result'] = result.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Result {
  Result({
    required this.leagueKey,
    required this.leagueName,
    required this.countryKey,
    required this.countryName,
    required this.leagueLogo,
    required this.countryLogo,
  });
  late final int leagueKey;
  late final String leagueName;
  late final int countryKey;
  late final String countryName;
  late final String? leagueLogo;
  late final String countryLogo;
  
  Result.fromJson(Map<String, dynamic> json){
    leagueKey = json['league_key'];
    leagueName = json['league_name'];
    countryKey = json['country_key'];
    countryName = json['country_name'];
    leagueLogo = json['league_logo'];
    countryLogo = json['country_logo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['league_key'] = leagueKey;
    _data['league_name'] = leagueName;
    _data['country_key'] = countryKey;
    _data['country_name'] = countryName;
    _data['league_logo'] = leagueLogo;
    _data['country_logo'] = countryLogo;
    return _data;
  }
}
