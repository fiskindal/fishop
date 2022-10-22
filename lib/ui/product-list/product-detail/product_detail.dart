import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => GoRouter.of(context).push('/'),
          ),
        ),
      ),
    );
  }
}
