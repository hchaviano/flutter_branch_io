import 'dart:async';

abstract class DeepLinkRepository {
  /// Initializes the `_buo` instance variable to a new `BranchUniversalObject`
  /// with the canonical identifier `'flutter/branch'`.
  void initialize({required String canonicalUrl});

  /// Generates a short dynamic link using the Branch.io SDK with the given
  /// `alias` and `appEnv`.
  /// Throws a [DeepLinkRepositoryException] when it fails.
  FutureOr<String?> generateDeepLink({
    String? alias,
  });

  Future<Map> getFirstReferringParams();

  Future<Map> getLatestReferringParams();

  Future<void> showShareSheet();
}
