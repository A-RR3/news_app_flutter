import 'package:dio/dio.dart';
import 'package:news_app_bloc/domain/interactors/interfaces/news_interface.dart';
import 'package:news_app_bloc/shared/network/remote/dio_helper.dart';

class NewsInteractorImpl implements NewsInteractor {
  final String _url = 'v2/top-headlines';

  @override
  Future getBusinessNews() async {
    return await DioHelper.getData(url: _url, query: {
      'country': 'us',
      'category': 'business',
      'apiKey': 'ae8350c74d954f6b9a9fb7ab74402673'
    });
  }

  @override
  Future getSportsNews() async {
    return await DioHelper.getData(url: _url, query: {
      'country': 'us',
      'category': 'sports',
      'apiKey': 'ae8350c74d954f6b9a9fb7ab74402673'
    });
  }

  @override
  Future getScienceNews() async {
    return await DioHelper.getData(url: _url, query: {
      'country': 'us',
      'category': 'science',
      'apiKey': 'ae8350c74d954f6b9a9fb7ab74402673'
    });
  }

  @override
  Future getSearchedNews(String value, CancelToken token) async {
    return await DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': value,
          'apiKey': 'ae8350c74d954f6b9a9fb7ab74402673',
        },
        cancelToken: token);
  }
}
