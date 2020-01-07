import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zabh_halal/model/allProducts_model.dart';
import 'package:zabh_halal/ui/tabs/1-main_page/subPages/product_details.dart';
import 'package:zabh_halal/utilities/colors.dart';
import 'package:zabh_halal/utilities/movie_card.dart';

class ProductsPage extends StatefulWidget {
  final List<Products> products;
  final String title;
  ProductsPage(this.products, this.title);
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
            child: TextD(
              title: '${widget.title}',
              fontSize: 22,
              textColor: Colors.white,
              height: 0.8,
            ),
          )
        ],
      ),
      body: widget.products.isEmpty
          ? Center(
              child: TextD(
                title: 'لا توجد منتجات متاحة',
                fontSize: 16,
              ),
            )
          : GridView.count(
              // childAspectRatio:MediaQuery.of(context).size.width/410,
              childAspectRatio: (MediaQuery.of(context).size.width / 2.66) /
                  (MediaQuery.of(context).size.height / 5.3),

              crossAxisSpacing: 10,
              padding: EdgeInsets.all(8),
              mainAxisSpacing: 10,
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate((widget.products.length), (index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, anim, secAnim) => ProductDetails(
                          'product$index',
                          widget.products[index],
                          service: widget.title,
                        ),
                        transitionDuration: Duration(seconds: 1),
                      )),
                  child: MovieCard(
                    cardTag: 'product$index',
                    img:
                        'http://alzabhalhalal.com/public/dash/assets/img/${widget.products[index].image}',
                    title: widget.products[index].name,
                  ),
                );
              }),
            ),
    );
  }
}
