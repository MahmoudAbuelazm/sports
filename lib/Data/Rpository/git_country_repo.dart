import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sports_app/Data/Models/git_country_model.dart';
import 'package:sports_app/Data/constants/constants.dart';

class GitCountryRepo {
 
Future<GitCountryModel?> GitCountry()async{
try{
  var response = await http.get(Uri.parse(
    "https://apiv2.allsportsapi.com/football/?met=Countries&APIkey=$apiKey"));
 
 var decodedRespons= jsonDecode(response.body);
  
  
  if(response.statusCode==200){
    GitCountryModel myRespons = GitCountryModel.fromJson(decodedRespons);
        
       return myRespons;
  }else {
    return null;
  }

 
 }catch(erorr){
return null;
 }
}
}