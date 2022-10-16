// ignore_for_file: must_be_immutable

part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  HomeState(this.currentIndex);
  int currentIndex = 0;
  @override
  List<Object?> get props => [currentIndex];
}

class HomeInitial extends HomeState {
  HomeInitial(super.currentIndex);

  @override
  List<Object?> get props => [currentIndex];
}

class HomeIndexChange extends HomeInitial {
  HomeIndexChange(super.currentIndex);
  @override
  List<Object?> get props => [currentIndex];
}
