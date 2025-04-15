import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:musicapp_client/core/constants/server_constant.dart';
import 'package:musicapp_client/core/failure/failure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository();
}

class HomeRepository {
  Future<Either<AppFailure, String>> uploadSong(
      {required File selectedThumbnail,
      required File selectedAudio,
      required String artist,
      required String songName,
      required String hexCode,
      required String token}) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse('${ServerConstant.serverURL}/song/upload'));

      request
        ..files.addAll([
          await http.MultipartFile.fromPath('song', selectedAudio.path),
          await http.MultipartFile.fromPath(
              'thumbnail', selectedThumbnail.path),
        ])
        ..fields.addAll(
          {
            'artist': artist,
            'song_name': songName,
            'hex': hexCode,
          },
        )
        ..headers.addAll(
          {
            'x-auth-token': token,
          },
        );

      final res = await request.send();

      if (res.statusCode != 201) {
        return Left(
          AppFailure(
            await res.stream.bytesToString(),
          ),
        );
      }
      return Right(await res.stream.bytesToString());
    } catch (e) {
      return Left(
        AppFailure(
          e.toString(),
        ),
      );
    }
  }
}
