import 'package:deep_link_repository/deep_link_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required DeepLinkRepository deepLinkRepository,
  })  : _deepLinkRepository = deepLinkRepository,
        super(const HomeState()) {
    on<GenerateDeepLink>(_onGenerateDeepLink);
    on<ShareDeepLink>(_onShareDeepLink);
  }

  final DeepLinkRepository _deepLinkRepository;

  Future<void> _onGenerateDeepLink(
    GenerateDeepLink event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      final deepLink = await _deepLinkRepository.generateDeepLink(
        alias: event.alias,
      );

      emit(
        state.copyWith(
          status: HomeStateStatus.success,
          deepLink: deepLink,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: HomeStateStatus.failure));
    }
  }

  Future<void> _onShareDeepLink(
    ShareDeepLink event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await _deepLinkRepository.showShareSheet();
    } catch (e) {
      emit(state.copyWith(status: HomeStateStatus.failure));
    }
  }
}
