/*
Se encarga de hacer las llamadas al 
*/ 



import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_models.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;


final _URL_NEWS   = 'newsapi.org';
final _APIKEY     = 'cdb7360d4f0249a8b1571b819aae64bc';

class NewsService with ChangeNotifier{
  List<Article> headlines =[];
  String _selectedCategory = 'business';

  List<Category> categories =  [
    Category( FontAwesomeIcons.building, 'business' ),
    Category( FontAwesomeIcons.tv, 'entertainment' ),
    Category( FontAwesomeIcons.addressCard, 'general' ),
    Category( FontAwesomeIcons.headSideVirus, 'health' ),
    Category( FontAwesomeIcons.vials , 'science' ),
    Category( FontAwesomeIcons.volleyball, 'sports' ),
    Category( FontAwesomeIcons.memory, 'technology' ),    
  ];

  Map<String, List<Article>> categoryArticles = {  };

  NewsService(){
    this.getTopHeadlines();
    categories.forEach((element) {
       this.categoryArticles[element.name] = [];
//       this.categoryArticles[element.name] = new List.empty();
    });
  }

  String get selectedCategory => this._selectedCategory;
  set selectedCategory (String valor){
    this._selectedCategory =valor;
    this.getArticlesByCategory(valor);

    notifyListeners();
  }


  List<Article> get getArticulosCategoriaSeleccionada => this.categoryArticles[this.selectedCategory]!;


  getTopHeadlines () async {
//   final url = '/top-headlines?apiKey=$_APIKEY&country=us';

  final url =  Uri.https( _URL_NEWS,   '/v2/top-headlines' , { 
      'apiKey' : _APIKEY, 
      'country' : 'us' 
       } );

   


   
   
   final resp  = await http.get( url );



   final newsResponse = newsResponseFromJson( resp.body );

   this.headlines.addAll( newsResponse.articles );
   notifyListeners();

  }

  getArticlesByCategory( String category) async {

    if (this.categoryArticles[category]!.length>0)
      return this.categoryArticles[category];

  final url =  Uri.https( _URL_NEWS,   '/v2/top-headlines' , { 
      'apiKey' : _APIKEY, 
      'country' : 'us' ,
      'category': category,
       } );  
   
   final resp  = await http.get( url );

   final newsResponse = newsResponseFromJson( resp.body );
  this.categoryArticles[category]!.addAll( newsResponse.articles );

   notifyListeners();    
  } 
  

}
