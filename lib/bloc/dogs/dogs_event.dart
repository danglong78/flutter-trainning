part of 'dogs_bloc.dart';

@immutable
abstract class DogsEvent {}

class DogsInitiate extends DogsEvent {}

class DogsRefresh extends DogsEvent {}

class DogsLoadMore extends DogsEvent {}

class DogsFetchData extends DogsEvent {}

class DogsCatchError extends DogsEvent {
  final String error;
  DogsCatchError(this.error);
}
