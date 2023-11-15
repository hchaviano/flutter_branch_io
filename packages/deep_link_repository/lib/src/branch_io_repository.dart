import 'dart:async';

import 'package:deep_link_repository/deep_link_repository.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

class BranchIORepository extends DeepLinkRepository {
  late BranchUniversalObject _buo;

  @override
  Future<void> initialize({required String canonicalUrl}) async {
    await FlutterBranchSdk.init(
        useTestKey: true);
    _buo = BranchUniversalObject(
      canonicalIdentifier: 'flutter/branch',
      canonicalUrl: canonicalUrl,
    );
  }

  @override
  FutureOr<String?> generateDeepLink({
    required String alias,
    Map<String, dynamic>? params,
  }) async {
    assert(alias.isNotEmpty, () {
      throw Exception('Error: alias cannot be empty.');
    });
    try {
      final linkProperties = BranchLinkProperties(alias: alias);

      if (params != null) {
        for (final param in params.entries) {
          linkProperties.addControlParam(param.key, param.value);
        }
      }
      final response = await FlutterBranchSdk.getShortUrl(
        buo: _buo,
        linkProperties: linkProperties,
      );

      if (response.success) {
        return response.result as String;
      } else {
        throw DeepLinkRepositoryException(
          message: response.errorMessage,
        );
      }
    } catch (error) {
      throw DeepLinkRepositoryException(
        message: error.toString(),
      );
    }
  }

  @override
  Future<Map> getFirstReferringParams() async {
    try {
      final params = await FlutterBranchSdk.getFirstReferringParams();
      return params;
    } catch (error) {
      throw DeepLinkRepositoryException(message: error.toString());
    }
  }

  @override
  Future<Map> getLatestReferringParams() async {
    try {
      final params = await FlutterBranchSdk.getLatestReferringParams();
      return params;
    } catch (error) {
      throw DeepLinkRepositoryException(message: error.toString());
    }
  }
}
