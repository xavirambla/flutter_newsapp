import 'package:flutter/material.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

import '../services/news_service.dart';

class Tab1Page extends StatefulWidget {
   const Tab1Page ({Key? key}) : super(key:  key);

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin{  //guarda el estado del widget cuando vas a la página 2. Es para mantener el scroll en la posición que estaba antes de ir a la pagina 2
   @override
   Widget build (BuildContext context){      
    final newsService = Provider.of<NewsService>( context );
    final headlines = newsService.headlines;


      return  Scaffold(
//         body: ListaNoticias( noticias: newsService.headlines),
        body: (headlines.length==0 )
          ? Center(
            child: CircularProgressIndicator(),
          )
          :ListaNoticias(noticias: headlines),
      );
   }
   
     @override
     // TODO: implement wantKeepAlive
//     bool get wantKeepAlive => throw UnimplementedError();
     bool get wantKeepAlive => true;   // es por si queremos destruir el estado por cualquier razón
}