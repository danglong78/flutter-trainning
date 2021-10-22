part of 'dogs_bloc.dart';

@immutable
abstract class DogsState {}

class DogsLoadInitial extends DogsState {}

class DogsLoadInProgress extends DogsState {}

class DogsLoadError extends DogsState {
  final DogsState oldState;
  final String error;
  DogsLoadError(this.error, this.oldState);
}

class DogsLoadSuccess extends DogsState {
  final List<Dog> listDogs;
  final bool hasMore;
  final int limit;
  DogsLoadSuccess(this.listDogs, this.hasMore, {this.limit = 10});
}
