
import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/tema.dart';

class ListaNoticias extends StatelessWidget {

  const ListaNoticias ({Key? key, required this.noticias }) : super(key: key);

  final List<Article> noticias;


  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index) {
        return _Noticia( noticia: this.noticias[index], index: index ) ;
      },
    );
  }
}

class _Noticia extends StatelessWidget {
  final Article noticia;
  final int index;


  const _Noticia({Key? key, required this.noticia, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTopBar( noticia:noticia , index: index),
        _TarjetaTitulo( noticia: noticia ),
        _TarjetaImagen(  noticia:noticia )     ,
        _TarjetaBody(  noticia:noticia )     ,
        _TarjetaBotones(),
        SizedBox( height: 10,),        

        Divider(),


    ],);
  }
}

class _TarjetaBotones extends StatelessWidget {
  const _TarjetaBotones({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: (){},
            fillColor: miTema.cardColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.star_border),
            ),
            SizedBox(width:10),
          RawMaterialButton(
            onPressed: (){},
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.more),
            )

        ]
        ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
    final Article noticia;   
  const _TarjetaBody({Key? key, required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20),
      child: Text(noticia.description ??"" )
    );
  }
}


class _TarjetaImagen extends StatelessWidget {
  final Article noticia;   
  const _TarjetaImagen({Key? key, required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(          // sirve para redondear las esquinas.
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomRight:  Radius.circular(50) ),
        child: Container(
          child:  (noticia.urlToImage !=null)
                ?FadeInImage(
                  placeholder: AssetImage('assets/img/giphy.gif'),
                  image: NetworkImage( noticia.urlToImage! )) 
                : Image( image: AssetImage('assets/img/no-image.png')
      
            )
        ),
      ),
    );
  }
}


class _TarjetaTitulo extends StatelessWidget {
  final Article noticia; 
  const _TarjetaTitulo({Key? key, required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:15 ),
      child: Text( noticia.title ??"", style : TextStyle (fontSize: 20, fontWeight: FontWeight.w700 ),
    ));
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Article noticia;
  final int index;
    
  const _TarjetaTopBar({
    Key? key, required this.noticia, required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container   (
      padding: EdgeInsets.symmetric(horizontal: 10),  //ponemos un espacio entre los objetos de dentro
      margin: EdgeInsets.only(bottom: 10), // deparamos este widget del próximo

      child:Row(
        children: [
          Text('${ index +1 }' , style: TextStyle(color: miTema.cardColor),),
          Text('${ noticia.source.name }'),
        
      ],)
    );
  }
}