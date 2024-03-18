class VersionUtil {
  static String getNextVersion(String currentVersion) {
    final List<String> versionParts = currentVersion.split('.');
    final int major = int.parse(versionParts[0]);
    final int minor = int.parse(versionParts[1]);

    if (minor == 9) {
      return '${major + 1}.0';
    } else {
      return '$major.${minor + 1}';
    }
  }
}
