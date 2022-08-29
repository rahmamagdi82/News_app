import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/component/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class Sciences extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsApp,NewsAppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        var list=NewsApp.get(context).sciences;
        return buildConBilder(list);
      },
    );
  }

}