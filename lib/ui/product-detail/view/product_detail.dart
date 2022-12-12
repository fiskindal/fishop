import 'package:fishop_firebase/fishop_firebase.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:kartal/kartal.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => GoRouter.of(context).pop(),
          ),
        ),
        body: FirestoreQueryBuilder<Product>(
          builder: (context, snapshot, child) {
            if (snapshot.isFetching) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('error ${snapshot.error}');
            }
            final product = snapshot.docs[int.fromEnvironment(id)];
            final data = product.data();
            return Container(
              child: Column(
                children: [
                  Center(
                    child: Image.network(
                      data.imgUrl.toString(),
                      width: context.width / 2,
                      height: context.height / 3,
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              data.title.toString(),
                            ),
                            Column(
                              children: [Text('Burada rating bar olacak')],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          query: productsRef.doc(id).reference.parent,
        ),
      ),
    );
  }
}
