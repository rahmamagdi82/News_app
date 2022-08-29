import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/component/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class Search extends StatelessWidget
{
  var searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsApp,NewsAppStates>(
      listener: (context,Object? state){},
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defultTextFormFeild(
                    validate: (value){
                      if(value!.isEmpty){
                        return 'search must be not empty';
                      }else
                      {
                        return null;
                      }
                    },
                    control: searchController,
                    type: TextInputType.text,
                    lable: 'Search',
                    prefix: Icons.search,
                    change: (value){
                      NewsApp.get(context).getSearch(value);
                    }
                ),
              ),
              Expanded(
                  child: buildConBilder(NewsApp.get(context).search,isSearch: true)),
            ],
          ),
        );
      },

    );
  }

}