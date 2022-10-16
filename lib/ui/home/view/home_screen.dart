import 'package:fishop/ui/home/cubit/home_cubit.dart';
import 'package:fishop/ui/product-list/view/product_listview.dart';
import 'package:fishop_firebase/fishop_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:kartal/kartal.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  final homeCubit = HomeCubit();
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _buildBodyWidget(),
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return BottomNavigationBar(
            onTap: (value) => context.read<HomeCubit>().setCurrentIndex(value),
            currentIndex: state.currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.healing,
                  ),
                  label: 'product list'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.approval,
                  ),
                  label: ''),
            ],
          );
        },
      ),
    ));
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      switch (state.currentIndex) {
        case 0:
          return const ProductListView();
        case 1:
          return Center(
            child: Text('ello'),
          );
        default:
          return const Text("Wrong selection");
      }
    });
  }
}
