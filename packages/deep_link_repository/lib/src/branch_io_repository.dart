import 'dart:async';

import 'package:deep_link_repository/deep_link_repository.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

class BranchIORepository extends DeepLinkRepository {
  late BranchUniversalObject _buo;

  @override
  void initialize({required String canonicalUrl}) {
    _buo = BranchUniversalObject(
      canonicalIdentifier: 'flutter/branch',
      canonicalUrl: canonicalUrl,
    );
  }

  @override
  FutureOr<String?> generateDeepLink({
    String? alias,
  }) async {
    try {
      final linkProperties = BranchLinkProperties(
        alias: alias ?? '',
      );

      final response = await FlutterBranchSdk.getShortUrl(
        buo: _buo,
        linkProperties: linkProperties,
      );

      if (!response.success) {
        return response.errorMessage;
      }

      return response.result;
    } catch (error) {
      DeepLinkRepositoryException(message: error.toString());
    }
    return null;
  }

  @override
  Future<Map> getFirstReferringParams() async {
    return await FlutterBranchSdk.getFirstReferringParams();
  }

  @override
  Future<Map> getLatestReferringParams() async {
    return await FlutterBranchSdk.getLatestReferringParams();
  }

  @override
  Future<void> showShareSheet() async {
    try {
      await FlutterBranchSdk.showShareSheet(
        buo: _buo,
        linkProperties: BranchLinkProperties(),
        messageText: '',
      );
    } catch (error) {
      DeepLinkRepositoryException(message: error.toString());
    }
  }
}
