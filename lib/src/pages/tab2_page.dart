import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_models.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService> ( context );

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
               _ListaCategorias() ,
               Expanded(
                child: ListaNoticias(noticias: newsService.getArticulosCategoriaSeleccionada ),
                )
          ])
        ,)
      );
  }
}

class _ListaCategorias extends StatelessWidget {
  const _ListaCategorias({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>( context ).categories;
    

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(), //para que se vea igual en ios que en android
        scrollDirection: Axis.horizontal, //scroll horizontal
        itemCount: categories.length,
        itemBuilder:  ((BuildContext context, int index) {
          final cName = categories[index].name;

          return  Padding (
            padding : EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryButton(categoria: categories[index]),
                SizedBox( height: 5,),
                Text( '${ cName[0].toUpperCase()}${cName.substring(1)}' ),   // poner la primera letra en mayúsculas
              ]
              ),
          );
        }),
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton({
    Key? key,
    required this.categoria,
  }) : super(key: key);

    final Category categoria;

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>( context);

    return GestureDetector(
      onTap: (() {
         print("hola mundo ${ categoria.name }"); 
         final newsService = Provider.of<NewsService>( context , listen:  false );
         newsService.selectedCategory = categoria.name;

      }),
      child: Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.symmetric (horizontal: 10),

          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white
          ),
          child: Icon(
            categoria.icon,
            color:  ( newsService.selectedCategory == this.categoria.name)  
              ? Colors.red
              : Colors.black54,
          ),
      ),
    );
    
    // Icon ( categoria.icon );
  }
}