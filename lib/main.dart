import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_bloc/core/presentation/theme_manager.dart';
import 'package:news_app_bloc/layout/news_layout.dart';
import 'package:news_app_bloc/shared/bloc_observer.dart';
import 'package:news_app_bloc/shared/network/local/cache_helper.dart';
import 'package:news_app_bloc/shared/network/remote/dio_helper.dart';

import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  bool isLight = CacheHelper.getBool(key: "isLight");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NewsCubit()..getBusiness(),
        child: BlocConsumer<NewsCubit, NewsStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: CacheHelper.getBool(key: 'isLight')
                    ? ThemeMode.light
                    : ThemeMode.dark,
                home: const NewsLayout(),
              );
            }));
  }
}
