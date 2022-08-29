import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business.dart';
import 'package:news_app/modules/sciences.dart';
import 'package:news_app/modules/sports.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cach_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsApp extends Cubit<NewsAppStates>
{
  NewsApp() : super(InitialState());

  static NewsApp get(context)=>BlocProvider.of(context);

  List screens=
  [
    Business(),
    Sports(),
    Sciences(),
  ];
  int currentIndex=0;
  List business=[];
  List sports=[];
  List sciences=[];
  bool darkMode=false;
  List search=[];
  int selectedItem=0;
  bool isDesktop=false;

  void changeScreens(int x)
  {
    currentIndex=x;
    if(x==1)
    {
      getSports();
    }
    if(x==2)
    {
      getSciences();
    }
    emit(ChangeState());
  }

  void changeSelectedItem(int index)
  {
    selectedItem=index;
    emit(ChangeSelectedItemState());
  }

  void desktop(bool value)
  {
    isDesktop=value;
    emit(DesktopState());
  }

  void getBusiness()
  {
    emit(GetBusinessLoadingState());

      DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          "country":"eg",
          "category":"business",
          "apikey":"f9a0dada5c8743e585a257a229719436",
        },
      ).then((value) {
        //print(value.data.toString());
        business=value.data['articles'] ;
        emit(GetBusinessState());
      }).catchError((error){
        print(error.toString());
        emit(GetBusinessErrorState(error.toString()));
      });
      emit(GetBusinessState());
  }

  void getSports()
  {
    emit(GetSportLoadingState());
    if(sports.length==0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          "country":"eg",
          "category":"sports",
          "apikey":"f9a0dada5c8743e585a257a229719436",
        },
      ).then((value) {
        sports=value.data['articles'] ;
        emit(GetSportState());
      }).catchError((error){
        emit(GetSportErrorState(error.toString()));
      });
    }else
      {
        emit(GetSportState());
      }

  }

  void getSciences()
  {
    emit(GetScienceLoadingState());
    if(sciences.length==0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          "country":"eg",
          "category":"science",
          "apikey":"f9a0dada5c8743e585a257a229719436",
        },
      ).then((value) {
        sciences=value.data['articles'] ;
        emit(GetScienceState());
      }).catchError((error){
        print(error.toString());
        emit(GetScienceErrorState(error.toString()));
      });
    }else
      {
        emit(GetScienceState());
      }

  }

  void changeMode({bool? fromShared})
  {
    if(fromShared != null){
      darkMode=fromShared;
      emit(ChangeModeState());
    }else
      {
        darkMode = !darkMode;
        CachHelper.putData(key: 'darkMode', value: darkMode).then((value) {
          emit(ChangeModeState());
        });
      }

  }

  void getSearch(String s)
  {
    emit(GetSearchLoadingState());
    DioHelper.getData(
        url: 'v2/everything',
        query:{
          "q":"$s",
          "apikey":"f9a0dada5c8743e585a257a229719436",
        },
      ).then((value) {
        search=value.data['articles'] ;
        emit(GetSearchState());
      }).catchError((error){
        print(error.toString());
        emit(GetSearchErrorState(error.toString()));
      });
  }

}