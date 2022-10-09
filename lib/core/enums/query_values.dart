enum QueryValues {
  version,
  platform,
  page,
  pageSize;

  MapEntry<String, String> toEntry(String value) {
    return MapEntry(name, value);
  }
}
