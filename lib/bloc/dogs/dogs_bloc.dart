import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demo_retrofit_moor/data/api/dio_exception.dart';
import 'package:demo_retrofit_moor/data/local/database.dart';
import 'package:demo_retrofit_moor/data/repository.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'dogs_event.dart';
part 'dogs_state.dart';

class DogsBloc extends Bloc<DogsEvent, DogsState> {
  DogsBloc() : super(DogsLoadInitial());
  int pageIndex = 0;
  @override
  Stream<DogsState> mapEventToState(DogsEvent event) async* {
    if (event is DogsInitiate) {
      yield* _mapDogsInitiateToState(event);
    } else if (event is DogsRefresh) {
      yield* _mapDogsRefreshToState(event);
    } else if (event is DogsLoadMore) {
      yield* _mapDogsLoadMoreToState(event);
    } else if (event is DogsFetchData) {
      yield* _mapDogsFetchDataToState(event);
    } else {
      yield* _mapDogsCatchErrorToState(event as DogsCatchError);
    }
  }

  Stream<DogsState> _mapDogsInitiateToState(DogsInitiate event) async* {
    yield DogsLoadInProgress();
    var listDogs = await Repository.instance.getDogs(pageIndex);
    bool hasMore = listDogs.length == 5;
    pageIndex += listDogs.length;
    yield DogsLoadSuccess(listDogs, hasMore);
  }

  Stream<DogsState> _mapDogsLoadMoreToState(DogsEvent event) async* {
    await Future.delayed(Duration(seconds: 2));
    if (state is DogsLoadSuccess && (state as DogsLoadSuccess).hasMore) {
      var loadMoreList = await Repository.instance.getDogs(pageIndex);
      pageIndex += loadMoreList.length;
      var listDogs = (state as DogsLoadSuccess).listDogs..addAll(loadMoreList);
      yield DogsLoadSuccess(
        listDogs,
        loadMoreList.length == 5,
      );
    }
  }

  Stream<DogsState> _mapDogsRefreshToState(DogsRefresh event) async* {
    var listDogs = (state as DogsLoadSuccess).listDogs..shuffle();
    yield DogsLoadSuccess(listDogs, (state as DogsLoadSuccess).hasMore);
  }

  Stream<DogsState> _mapDogsFetchDataToState(DogsFetchData event) async* {
    yield DogsLoadInProgress();
    try {
      await Repository.instance.fetchAndSaveListDogs();
      add(DogsInitiate());
    } catch (err) {
      switch (err.runtimeType) {
        case DioError:
          add(DogsCatchError(
              DioException.fromError(err as DioError).toString()));
          break;
        default:
          final res = err.toString();
          add(DogsCatchError(res));
      }
    }
  }

  Stream<DogsState> _mapDogsCatchErrorToState(DogsCatchError event) async* {
    yield DogsLoadError(event.error, state);
  }
}
