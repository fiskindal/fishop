import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial(0));

  setCurrentIndex(int index) {
    emit(HomeIndexChange(index));
  }
}
