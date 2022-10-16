import 'package:fishop_firebase/fishop_firebase.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:go_router/go_router.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<Product>(
      builder: (context, snapshot, child) {
        if (snapshot.isFetching) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('error ${snapshot.error}');
        }
        return GridView.builder(
          itemCount: snapshot.docs.length,
          itemBuilder: (context, index) {
            final product = snapshot.docs[index];
            if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
              snapshot.fetchMore();
            }
            return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(blurRadius: 100),
                ],
              ),
              child: GridTile(
                  child: Card(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Column(
                    children: [
                      Text(
                        product.data().productName.toString(),
                      ),
                      Text(
                        product.data().unitPrice.toString(),
                      ),
                      Text(
                        product.data().rating.toString(),
                      ),
                      Image.network(
                        product.data().imgUrl as String,
                        height: context.height / 10,
                        width: context.width / 10,
                      ),
                      IconButton(
                        onPressed: () =>
                            context.go('/details', extra: product.id),
                        icon: Icon(FontAwesomeIcons.buyNLarge),
                      )
                    ],
                  ),
                ),
              )),
            );
          },
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        );
      },
      query: productsRef
          .orderByTrendProduct(
            descending: true,
          )
          .reference,
    );
  }
}
