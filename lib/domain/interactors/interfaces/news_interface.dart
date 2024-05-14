import 'package:dio/dio.dart';

abstract interface class NewsInteractor {
  Future<dynamic> getBusinessNews();

  Future<dynamic> getSportsNews();

  Future<dynamic> getScienceNews();

  Future<dynamic> getSearchedNews(String value, CancelToken token);
}
