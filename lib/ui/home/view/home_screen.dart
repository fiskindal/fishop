import 'package:fishop/core/init/localstorage/localstorage.dart';
import 'package:fishop/ui/home/cubit/home_cubit.dart';
import 'package:fishop/ui/product-list/view/product_listview.dart';
import 'package:fishop_firebase/fishop_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
      appBar: AppBar(
        actions: [],
      ),
      drawer: Drawer(
        child: ListView(children: [
          const DrawerHeader(
            decoration: BoxDecoration(),
            child: Text('Fishop'),
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () async {
              final authenticationRepository = AuthenticationRepository();
              await authenticationRepository.logOut();
              LocaleManager locale = LocaleManager.instance;
              await locale.clearAll();
              GoRouter.of(context).go('/login');
            },
          ),
          ListTile(
            title: const Text('X'),
            onTap: () {
              GoRouter.of(context).pop();
            },
          ),
        ]),
      ),
      body: _buildBodyWidget(),
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return BottomNavigationBar(
            onTap: (value) {
              context.read<HomeCubit>().setCurrentIndex(value);
            },
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
                  label: 'cart'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.people,
                  ),
                  label: 'profile'),
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
          return ProductListView();
        case 1:
          return Center(
            child: Text('ello'),
          );
        case 2:
          return Center(
            child: Text('sepet'),
          );
        default:
          return const Text("Wrong selection");
      }
    });
  }
}
