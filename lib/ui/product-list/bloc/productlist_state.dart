part of 'productlist_bloc.dart';

abstract class ProductlistState extends Equatable {
  const ProductlistState();
  
  @override
  List<Object> get props => [];
}

class ProductlistInitial extends ProductlistState {}
