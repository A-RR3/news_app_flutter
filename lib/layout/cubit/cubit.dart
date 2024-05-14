import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_bloc/domain/interactors/interactor_impl/news_impl.dart';
import 'package:news_app_bloc/domain/interactors/interfaces/news_interface.dart';
import 'package:news_app_bloc/domain/models/news_model.dart';
import 'package:news_app_bloc/layout/cubit/states.dart';
import 'package:news_app_bloc/modules/business/business_screen.dart';
import 'package:news_app_bloc/modules/science_screen/science_screen.dart';
import 'package:news_app_bloc/modules/settings_screen/settings_screen.dart';
import 'package:news_app_bloc/modules/sports_screen/sports_screen.dart';

import '../../shared/network/local/cache_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'science'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'settings'),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
    const SettingsScreen()
  ];

  void changeBottomNavBar(int index) async {
    currentIndex = index;
    if (index == 1) {
      await getSports();
    }
    if (index == 2) {
      await getScience();
    }
    emit(NewsChangeNavBarState());
  }

  List<NewsModel> businessNews = [];
  List<NewsModel> sportsNews = [];
  List<NewsModel> scienceNews = [];
  List<NewsModel> searchList = [];
  TextEditingController searchController = TextEditingController();
  CancelToken cancelToken = CancelToken();

  final NewsInteractor service = NewsInteractorImpl();

  void getBusiness() async {
    emit(NewsGetBusinessLoadingState());

    await service.getBusinessNews().then((res) {
      if (res.statusCode == 200) {
        for (var article in res.data['articles']) {
          businessNews.add(NewsModel.fromMap(article));
        }
      }
      emit(NewsGetBusinessSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(NewsGetBusinessErrorState(e.toString()));
    });
  }

  Future getScience() async {
    emit(NewsGetScienceLoadingState());
    if (scienceNews.isEmpty) {
      await service.getScienceNews().then((res) {
        if (res.statusCode == 200) {
          for (var article in res.data['articles']) {
            scienceNews.add(NewsModel.fromMap(article));
          }
        }
        emit(NewsGetScienceSuccessState());
      }).catchError((e) {
        print(e.toString());
        emit(NewsGetScienceErrorState(e.toString()));
      });
    }
  }

  Future getSports() async {
    emit(NewsGetSportsLoadingState());
    if (sportsNews.isEmpty) {
      await service.getSportsNews().then((res) {
        if (res.statusCode == 200) {
          for (var article in res.data['articles']) {
            sportsNews.add(NewsModel.fromMap(article));
          }
        }
        emit(NewsGetSportsSuccessState());
      }).catchError((e) {
        print(e.toString());
        emit(NewsGetSportsErrorState(e.toString()));
      });
    }
  }

  void getSearched(String value) async {
    searchList = [];
    emit(NewsGetSearchLoadingState());
    await service.getSearchedNews(value, cancelToken).then((res) {
      if (res.statusCode == 200) {
        for (var article in res.data['articles']) {
          searchList.add(NewsModel.fromMap(article));
        }
      }
      emit(NewsGetSearchSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(NewsGetSearchErrorState(e.toString()));
    });
    }

  void cancelRequestToken() {
    cancelToken.cancel('cancelled');
    cancelToken = CancelToken();
  }

  bool isLight = CacheHelper.getBool(key: 'isLight');

  void changeMode() {
    isLight = !isLight;
    CacheHelper.setBool(key: "isLight", value: isLight).then((value) {
      emit(NewsChangeModeState());
    });
  }
}
