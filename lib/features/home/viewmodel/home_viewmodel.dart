import 'dart:io';
import 'dart:ui';

import 'package:fpdart/fpdart.dart';
import 'package:musicapp_client/core/providers/current_user_notifier.dart';
import 'package:musicapp_client/core/widgets/utils.dart';
import 'package:musicapp_client/features/home/repositories/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

@riverpod
class HomeViewmodel extends _$HomeViewmodel {
  late HomeRepository _homeRepository;

  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    return null;
  }

  Future<void> uploadSong({
    required File selectedThumbnail,
    required File selectedAudio,
    required String artist,
    required String songName,
    required Color selectedColor,
  }) async {
    state = const AsyncValue.loading();
    final res = await _homeRepository.uploadSong(
      selectedThumbnail: selectedThumbnail,
      selectedAudio: selectedAudio,
      artist: artist,
      songName: songName,
      hexCode: rgbToHex(selectedColor),
      token: ref.read(currentUserNotifierProvider)!.token,
    );

    final val = switch (res) {
      Left(value: final l) => AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => AsyncValue.data(r),
    };
  }
}
