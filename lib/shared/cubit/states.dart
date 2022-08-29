abstract class NewsAppStates
{}

class InitialState extends NewsAppStates
{}

class ChangeState extends NewsAppStates
{}

class ChangeSelectedItemState extends NewsAppStates
{}

class DesktopState extends NewsAppStates
{}

class GetBusinessState extends NewsAppStates
{}

class GetBusinessLoadingState extends NewsAppStates
{}

class GetBusinessErrorState extends NewsAppStates
{
    final String error;
    GetBusinessErrorState(this.error);
}

class GetSportState extends NewsAppStates
{}

class GetSportLoadingState extends NewsAppStates
{}

class GetSportErrorState extends NewsAppStates
{
    final String error;
    GetSportErrorState(this.error);
}

class GetScienceState extends NewsAppStates
{}

class GetScienceLoadingState extends NewsAppStates
{}

class GetScienceErrorState extends NewsAppStates
{
    final String error;
    GetScienceErrorState(this.error);
}

class ChangeModeState extends NewsAppStates
{}

class GetSearchState extends NewsAppStates
{}

class GetSearchLoadingState extends NewsAppStates
{}

class GetSearchErrorState extends NewsAppStates
{
    final String error;
    GetSearchErrorState(this.error);
}
