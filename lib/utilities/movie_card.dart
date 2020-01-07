import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MovieCard extends StatelessWidget {
  final String img;
  final String title;
  final String cardTag;
  MovieCard({this.img, this.title, this.cardTag});

  Widget _movieTitle(context) {
    return Builder(
      
      builder: (context) {
        return MediaQuery (
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: Container(
            // padding: EdgeInsets.fromLTRB(10, 2, 10, 0),
            child: Container(
              height: MediaQuery.of(context).size.height/32,
              alignment: Alignment.center,
              child: AutoSizeText(
              
                '${title} ',
                minFontSize: 1,
                maxFontSize: 24,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  // fontSize: 5,
                  // fontSize: MediaQuery.of(context).devicePixelRatio*4,
                  fontFamily: 'thin',
                  height:  0.65,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
                maxLines: 1,
              ),
            ),
          ),
        );
      }
    );
  }

  Widget _movieCard(BuildContext context) {
    var orient = MediaQuery.of(context).orientation;
    return Container(
      height: orient == Orientation.landscape
          ? MediaQuery.of(context).size.height / 0.855
          : MediaQuery.of(context).size.height / 5.3,
      width: orient == Orientation.landscape
          ? MediaQuery.of(context).size.width / 2.2
          : MediaQuery.of(context).size.width / 2,
      //constraints: BoxConstraints.expand(width: 197, height: 175),
      child: Hero(
        tag: '$cardTag',
        child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: img == null || img.isEmpty || img.contains('null')
                ? Image.asset('assets/icons/logo.png')
                : Image.network(
                    img,
                    fit: BoxFit.cover,

                    alignment: Alignment.center
                  )),
      ),
    
      decoration: BoxDecoration(
        // border: BoxBorder(),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,    
        boxShadow: [
          BoxShadow(blurRadius: 4, spreadRadius: 0, color: Colors.grey),
        ],
        // image: DecorationImage(
        //   fit: BoxFit.cover,
        //   image: NetworkImage(
        //     '${img}',
        //   ),
        // ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child: Container(
        // height: MediaQuery.of(context).orientation == Orientation.landscape
        //     ? MediaQuery.of(context).size.height / 0.8
        //     : MediaQuery.of(context).size.height / 2.5,
        // width: MediaQuery.of(context).orientation == Orientation.landscape
        //     ? MediaQuery.of(context).size.width / 2.2
        //     : MediaQuery.of(context).size.width / 2,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(blurRadius: 2, color: Colors.grey),
            ],
            color: Theme.of(context).appBarTheme.color,
            // border: Border.all(
            //   // color: Colors.white,
            //   width: 0,
            //   style: BorderStyle.solid,
            // ),
          ),
          child: Column(
            children: <Widget>[
              _movieCard(context),
              SizedBox(
                height: 2,
              ),
              _movieTitle(context),
            ],
          ),
        ),
      ),
    );
  }
}
