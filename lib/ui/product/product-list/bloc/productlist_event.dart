part of 'productlist_bloc.dart';

abstract class ProductlistEvent extends Equatable {
  const ProductlistEvent();

  @override
  List<Object> get props => [];
}

class ProductListInitialEvent extends ProductlistEvent {
  final Query<Product> query;
  ProductListInitialEvent(this.query);
  @override
  List<Object> get props => [query];
}
