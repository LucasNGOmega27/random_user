enum Env { dev, prod }

class Config {
  final String apiBaseUrl;
  final bool mockApi;
  final bool flag;

  Config({
    required this.apiBaseUrl,
    required this.mockApi,
    required this.flag,
  });
}

class ConfigProfiles {
  ConfigProfiles._();

  static final Config dev = Config(
    apiBaseUrl: 'https://randomuser.me/api/',
    mockApi: true,
    flag: true,
  );
  static final Config prod = Config(
    apiBaseUrl: 'https://randomuser.me/api/',
    mockApi: false,
    flag: false,
  );
}
