part of 'gift_bloc.dart';

abstract class GiftState extends Equatable {
  const GiftState();
  
  @override
  List<Object> get props => [];
}

class GiftInitial extends GiftState {}

class GiftLoadedState extends GiftState {
  final List<Images> model;

  GiftLoadedState(this.model);
  
  @override
  List<Object> get props => [model];
}

