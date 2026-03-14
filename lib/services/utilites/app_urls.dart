class AppUrls {
  //base url for api calls
  static const String baseUrl = 'https://disease.sh/v3/covid-19/';
  static const String countriesList = "https://disease.sh/v3/covid-19/countries";

  //fetch world covid data
  static const String worldStatesApi = baseUrl + "all";
  static const String countriesListApi = baseUrl + "countries";
  
}