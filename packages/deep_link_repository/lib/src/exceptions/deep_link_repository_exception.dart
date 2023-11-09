/// Exception thrown when a request could not be completed by
///  the Deep Link Repository.
class DeepLinkRepositoryException implements Exception {
  const DeepLinkRepositoryException({required this.message});

  final String message;
}
