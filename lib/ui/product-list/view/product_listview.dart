import 'package:fishop_firebase/fishop_firebase.dart';
import 'package:flutter/material.dart';
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
            return GridTile(
                child: GestureDetector(
              onTap: () => GoRouter.of(context)
                  .push('/product/${product.id}', extra: product.id),
              child: Card(
                semanticContainer: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Image.network(product.data().imgUrl as String,
                          width: context.dynamicWidth(0.12),
                          height: context.dynamicHeight(0.12)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        ElevatedButton(
                          child: Text('add to cart'),
                          onPressed: () => print('eklemedim' /**TODO: */),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
          },
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
