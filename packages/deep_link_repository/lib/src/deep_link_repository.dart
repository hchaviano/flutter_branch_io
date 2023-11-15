import 'dart:async';

abstract class DeepLinkRepository {
  /// Initializes the `_buo` instance variable to a new `BranchUniversalObject`
  /// with the canonical identifier `'flutter/branch'`.
  Future<void> initialize({required String canonicalUrl});

  /// Generates a short dynamic link using the Branch.io SDK with the given
  /// `alias` and `params`.
  /// Throws a [DeepLinkRepositoryException] when it fails.
  FutureOr<String?> generateDeepLink({
    required String alias,
    Map<String, dynamic>? params,
  });

  /// Returns a `Map` containing the first referring parameters.
  /// Throws a [DeepLinkRepositoryException] if the operation fails.
  ///
  /// Note: If you ever want to access the original session params
  /// (the parameters passed in for the first install event only),
  /// you can use this function. This is useful if you only want to
  /// reward users who newly installed the app from a referral link.
  FutureOr<Map?> getFirstReferringParams();

  /// Returns a `Map` containing the latest referring parameters.
  /// Throws a [DeepLinkRepositoryException] if the operation fails.
  ///
  /// Note: These session parameters will be available at any point later
  /// on with this command. If no parameters are available then Branch
  /// will return an empty dictionary.
  /// This refreshes with every new session (app installs AND app opens).
  FutureOr<Map?> getLatestReferringParams();
}
