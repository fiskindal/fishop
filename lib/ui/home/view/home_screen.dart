import 'package:fishop_firebase/fishop_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirestoreQueryBuilder<Product>(
        builder: (context, snapshot, child) {
          if (snapshot.isFetching) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('error ${snapshot.error}');
          }
          return GridView.builder(
            itemBuilder: (context, index) {
              final product = snapshot.docs[index];
              if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                // Tell FirestoreQueryBuilder to try to obtain more items.
                // It is safe to call this function from within the build method.
                snapshot.fetchMore();
              }
              return Container(
                child:
                    Column(children: [Text(product.data().rating.toString())]),
              );
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
      ),
    );
  }
}
