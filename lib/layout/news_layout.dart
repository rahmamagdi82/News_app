import 'package:flutter/material.dart';
import 'package:news_app/modules/search.dart';
import 'package:news_app/shared/component/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';

class HomeNews extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: const Text(
                'News App',
              ),
              actions: [
                IconButton(
                    onPressed: (){
                      navigation(context, Search());
                    },
                    icon: const Icon(
                      Icons.search,
                    ),
                ),
                IconButton(
                  onPressed: (){
                    NewsApp.get(context).changeMode();
                  },
                  icon: const Icon(
                    Icons.brightness_4_outlined,
                  ),
                ),
              ],
            ),
            body: NewsApp.get(context).screens[NewsApp.get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: NewsApp.get(context).currentIndex,
              onTap: (index) {
                NewsApp.get(context).changeScreens(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Business',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.sports_baseball),
                  label: 'Sports',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.science),
                  label: 'Science',
                ),
              ],
            ),
          );
  }
}