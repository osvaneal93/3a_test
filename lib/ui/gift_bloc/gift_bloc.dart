import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prueba_3a/data/repository/gift_repo.dart';

part 'gift_event.dart';
part 'gift_state.dart';

class GiftBloc extends Bloc<GiftEvent, GiftState> {
  final GithyRepo _giftRepo; 
  GiftBloc(this._giftRepo) : super(GiftInitial()) {
    on<GiftEvent>((event, emit) async{
      final giftList  = await _giftRepo.getGit();
      emit(GiftLoadedState(giftList));
    });
  }
}
