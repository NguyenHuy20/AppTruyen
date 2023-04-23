class EnvironmentConfig {
  static const APP_NAME = String.fromEnvironment('DART_DEFINES_APP_NAME',
      defaultValue: "Truyen Full");
  static const APP_SUFFIX = String.fromEnvironment('DART_DEFINES_APP_SUFFIX');
  static const BASE_URL = String.fromEnvironment('DART_DEFINES_BASE_URL',
      defaultValue: "https://truyen-clone.getdata.one/");
  static const BASE_IMAGE_URL =
      String.fromEnvironment('DART_DEFINES_BASE_IMAGE_URL', defaultValue: "");
}
