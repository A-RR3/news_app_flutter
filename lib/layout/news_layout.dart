import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_bloc/layout/cubit/cubit.dart';
import 'package:news_app_bloc/modules/search/search_screen.dart';

import '../core/utils/navigation_services.dart';
import '../core/values/translation_keys.dart';
import 'cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text(TranslationKeys.appName),
                actions: [
                  IconButton(
                      onPressed: () {
                        NavigationServices.navigateTo(
                            context, const SearchScreen());
                      },
                      icon: const Icon(Icons.search)),
                  IconButton(
                    onPressed: () {
                      cubit.changeMode();
                    },
                    icon: const Icon(
                      Icons.brightness_4_outlined,
                    ),
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                  currentIndex: cubit.currentIndex,
                  items: cubit.items,
                  onTap: (value) => cubit.changeBottomNavBar(value)),
            ),
          );
        });
  }
}
