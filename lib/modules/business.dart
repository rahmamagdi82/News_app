import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/component/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:responsive_builder/responsive_builder.dart';
class Business extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsApp,NewsAppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        List list=NewsApp.get(context).business;
        return ScreenTypeLayout(
          mobile: Builder(
            builder: (context) {
              NewsApp.get(context).desktop(false);
              return buildConBilder(list);
            }
          ),
          desktop: Builder(
            builder: (context) {
              NewsApp.get(context).desktop(true);
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: buildConBilder(list)
                  ),
                  if(list.length >0)
                   Expanded(
                      child: Container(
                        color: Colors.grey[200],
                        height: double.infinity,
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                            '${list[NewsApp.get(context).selectedItem]['description']}',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                  )
                ],
              );
            }
          ),
          breakpoints: ScreenBreakpoints(
            desktop: 650.0,
            tablet: 600.0,
            watch: 100.0,
          ),
        );
      },
    );
  }
}