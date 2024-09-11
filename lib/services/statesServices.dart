import 'dart:convert';
import 'package:covid_19_tracker_app/models/statsModel.dart';
import 'package:covid_19_tracker_app/services/utilities/appUrls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/countriesModel.dart';

class StatesServicesProvider extends ChangeNotifier{
  ProductsModel? statesServices;
  Future<void> parseRecords() async{
     Response response =await http.get(Uri.parse(CountriesUrl.baseurl));

    try{
      if(response.statusCode==200){
        // print("StatusCode : ${response.body}");
        var data=jsonDecode(response.body);
        statesServices= ProductsModel.fromJson(data);
      }
      else{
        statesServices=null;
      }
    }
    catch(e){
      print(e.toString());
      statesServices=null;
    }
  }
}

class CountriesServiceProvider extends ChangeNotifier{
  CountriesModel? countriesModel;

  Future<List<dynamic>> parseCountryRecords() async{
    var data;
    Response response=await http.get(Uri.parse(CountriesUrl.countriesList));
    // print('model: ${response.body}');
    if(response.statusCode==200){
      data=jsonDecode(response.body);
    }
    return data;
  }
}
