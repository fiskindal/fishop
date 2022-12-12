part of 'productlist_bloc.dart';

abstract class ProductlistState extends Equatable {
  const ProductlistState();

  @override
  List<Object?> get props => [];
}

class ProductlistInitialState extends ProductlistState {
  final Query<Product> reference;
  const ProductlistInitialState({required this.reference});

  @override
  List<Object> get props => [reference];
}
