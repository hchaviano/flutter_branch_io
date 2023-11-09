part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class GenerateDeepLink extends HomeEvent {
  const GenerateDeepLink({this.alias});

  final String? alias;

  @override
  List<Object?> get props => [alias];
}

class ShareDeepLink extends HomeEvent {
  const ShareDeepLink();
}
