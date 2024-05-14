import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_bloc/core/values/constants.dart';
import 'package:news_app_bloc/layout/cubit/cubit.dart';
import 'package:news_app_bloc/layout/cubit/states.dart';

import '../../shared/components/news_item.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          var list = NewsCubit.get(context).businessNews;
          if (list.isNotEmpty) {
            return Padding(
              padding: kDefaultPadding,
              child: ListView.separated(
                  itemBuilder: (context, index) =>
                      NewsItem(article: list[index]),
                  separatorBuilder: (context, index) => verticalSpace(),
                  itemCount: 10),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        listener: (context, state) {});
  }
}
