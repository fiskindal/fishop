import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'productlist_event.dart';
part 'productlist_state.dart';

class ProductlistBloc extends Bloc<ProductlistEvent, ProductlistState> {
  ProductlistBloc() : super(ProductlistInitial()) {
    on<ProductlistEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
