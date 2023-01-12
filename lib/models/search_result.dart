class SearchResult {
  final bool cancel;
  final bool? manual;

  SearchResult({
    required this.cancel,
    this.manual,
  });
  // TODO: name, description, latlon

  @override
  String toString() {
    return '{ cancel: $cancel, manual: $manual }';
  }
}
