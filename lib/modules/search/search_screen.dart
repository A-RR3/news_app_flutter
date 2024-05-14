import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/presentation/palette.dart';
import '../../core/values/constants.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/news_item.dart';
import '../../shared/network/local/cache_helper.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          bool isDark = !CacheHelper.getBool(key: 'isLight');

          return PopScope(
              canPop: true,
              onPopInvoked: (didPop) => cubit.searchController.clear(),
              child: SafeArea(
                  child: Scaffold(
                appBar: AppBar(),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: cubit.searchController,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          cubit.cancelRequestToken();
                          cubit.getSearched(value);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: isDark ? Colors.white : Colors.black87,
                                width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: 'Enter a search term',
                          prefixIcon: Icon(Icons.search,
                              color: isDark ? Palette.darkThemeText : null),
                          hintStyle: TextStyle(
                              color: isDark ? Palette.darkThemeText : null),
                        ),
                      ),
                      verticalSpace(),
                      Expanded(
                          child: state is NewsGetSearchLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : cubit.searchList.isEmpty
                                  ? const Center(
                                      child: SizedBox(
                                        child: Text('No result shown'),
                                      ),
                                    )
                                  : ListView.separated(
                                      itemBuilder: (context, index) {
                                        return NewsItem(
                                            article: cubit.searchList[index]);
                                      },
                                      separatorBuilder: (context, index) =>
                                          verticalSpace(),
                                      itemCount: 10)),
                    ],
                  ),
                ),
              )));
        },
        listener: (context, state) {});
  }
}
