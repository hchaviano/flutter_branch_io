part of 'home_bloc.dart';

enum HomeStateStatus {
  initial,
  loading,
  success,
  failure,
}

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStateStatus.initial,
    this.deepLink,
  });

  final HomeStateStatus status;
  final String? deepLink;

  HomeState copyWith({
    HomeStateStatus? status,
    String? deepLink,
  }) {
    return HomeState(
      status: status ?? this.status,
      deepLink: deepLink ?? this.deepLink,
    );
  }

  @override
  List<Object?> get props => [status, deepLink];
}
