import 'package:fishop_firebase/fishop_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:kartal/kartal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FirestoreQueryBuilder<Product>(
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
                    child: Column(
                  children: [
                    Text(
                      product.data().productName.toString(),
                    ),
                    Text(
                      product.data().rating.toString(),
                    ),
                    FittedBox(
                      fit: BoxFit.fill,
                      child: Image.network(
                        product.data().imgUrl as String,
                        height: context.height / 10,
                        width: context.width / 10,
                      ),
                    )
                  ],
                ));
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
        ),
      ),
    );
  }
}
