import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fishop_firebase/fishop_firebase.dart';

part 'productlist_event.dart';
part 'productlist_state.dart';

class ProductlistBloc extends Bloc<ProductlistEvent, ProductlistInitialState> {
  ProductlistBloc()
      : super(ProductlistInitialState(
            reference: productsRef
                .orderByTrendProduct(
                  descending: true,
                )
                .reference)) {
    on<ProductListInitialEvent>(_onGetProductList);
  }

  Future<Query<Product>> _onGetProductList(ProductListInitialEvent event,
      Emitter<ProductlistInitialState> emit) async {
    return productsRef
        .orderByTrendProduct(
          descending: true,
        )
        .reference;
  }
}
