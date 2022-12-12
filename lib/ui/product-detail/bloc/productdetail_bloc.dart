import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'productdetail_event.dart';
part 'productdetail_state.dart';

class ProductdetailBloc extends Bloc<ProductdetailEvent, ProductdetailState> {
  ProductdetailBloc() : super(ProductdetailInitial()) {
    on<ProductdetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
