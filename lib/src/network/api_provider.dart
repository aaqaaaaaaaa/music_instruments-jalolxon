import "dart:async";
import "dart:convert";
import "dart:core";
import "dart:io";

// import "package:fluttertaxi/src/models/order.dart";
import "package:http/http.dart" as http;
import "package:shared_preferences/shared_preferences.dart";
import "http_result.dart";

ApiProvider? _apiProvider;

ApiProvider get provider {
  _apiProvider ??= ApiProvider();
  return _apiProvider!;
}

class ApiProvider {
  final String _baseUrl = "http://bestplay.uz/api/";

  static const Duration _duration = Duration(seconds: 30);

  Future<HttpResult> sendImage(String image) async {
    String url = "${_baseUrl}upload-file";
    var request = http.MultipartRequest("POST", Uri.parse(url));
    request.headers.addAll(await _header());
    // request.fields["title"] = title;
    // request.fields["name"] = name;

    request.files.add(await http.MultipartFile.fromPath("file", image));

    var response = await request.send();
    http.Response responseData = await http.Response.fromStream(response);
    return _result(responseData);
  }

  static Future<HttpResult> _getResponse(String url) async {
    print(url);
    try {
      http.Response response = await http
          .get(
            Uri.parse(url),
            headers: await _header(),
          )
          .timeout(_duration);
      return _result(response);
    } on TimeoutException catch (_) {
      return HttpResult(
        result: "Internet Error",
        isSuccess: false,
        statusCode: -1,
      );
    } on SocketException catch (_) {
      return HttpResult(
        result: "Internet Error",
        isSuccess: false,
        statusCode: -1,
      );
    }
  }

  static Future<HttpResult> _postResponse(String url, data) async {
    print(url);
    print(data);
    // print(await _header());
    try {
      http.Response response = await http
          .post(
            Uri.parse(url),
            body: data,
            headers: await _header(),
          )
          .timeout(_duration);
      return _result(response);
    } on TimeoutException catch (_) {
      return HttpResult(
        result: "Internet Error",
        isSuccess: false,
        statusCode: -1,
      );
    } on SocketException catch (_) {
      return HttpResult(
        result: "Internet Error",
        isSuccess: false,
        statusCode: -1,
      );
    }
  }

  static _header() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('authKey') ?? '';
    String lan = 'uz';
    if (token == "") {
      return {"Accept-Language": lan};
    } else {
      return {"Authorization": "Bearer $token", "Accept-Language": lan};
    }
  }

  static HttpResult _result(http.Response response) {
    print(response.statusCode);
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return HttpResult(
        statusCode: response.statusCode,
        isSuccess: true,
        result: json.decode(
          utf8.decode(
            response.bodyBytes,
          ),
        ),
      );
    } else if (response.statusCode >= 500 || response.statusCode == 404) {
      return HttpResult(
        statusCode: response.statusCode,
        isSuccess: false,
        result: "Server error",
      );
    } else {
      return HttpResult(
        statusCode: response.statusCode,
        isSuccess: false,
        result: json.decode(
          utf8.decode(
            response.bodyBytes,
          ),
        ),
      );
    }
  }

  Future<HttpResult> sendPhone(String phone, String signature) async {
    String url = "${_baseUrl}auth/register-v1/phone";
    return await _postResponse(url, {
      "phone": phone,
      "signature": signature,
    });
  }

  Future<HttpResult> updatePhone(String phone, String signature) async {
    String url = "${_baseUrl}profile-manager/update-username/phone";
    return await _postResponse(url, {
      "phone": phone,
      "signature": signature,
    });
  }

  Future<HttpResult> verifyPhone({
    required String phone,
    required String code,
    required String deviceId,
    required String deviceName,
    required String deviceToken,
  }) async {
    String url = "${_baseUrl}auth/register-v1/verify";
    return await _postResponse(url, {
      "phone": phone,
      "code": code,
      "device_id": deviceId,
      "device_name": deviceName,
      "device_token": deviceToken,
    });
  }

  Future<HttpResult> verifyNewPhone(
      {required String phone, required String code}) async {
    String url = "${_baseUrl}profile-manager/update-username/verify";
    return await _postResponse(url, {"phone": phone, "code": code});
  }

  Future<HttpResult> sendSms(
    String phone,
    String code,
    String deviceName,
    String deviceId,
    String deviceToken,
  ) async {
    String url = "${_baseUrl}auth/register/verify";
    return await _postResponse(url, {
      "phone": phone,
      "code": code,
      "device_id": deviceId,
      "device_name": deviceName,
      "device_token": deviceToken,
    });
  }

  Future<HttpResult> register({
    required String firstname,
    required String phone,
    required String code,
    required String img,
    required String lastname,
    required String deviceName,
    required String deviceId,
    required String deviceToken,
    required String regionId,
    required String districsId,
  }) async {
    String url = "${_baseUrl}auth/register-v1/register";
    return await _postResponse(url, {
      "img": img,
      "firstname": firstname,
      "lastname": lastname,
      "device_id": deviceId,
      "device_name": deviceName,
      "device_token": deviceToken,
      "district_id": districsId,
      "region_id": regionId,
      "phone": phone,
      "code": code,
    });
  }

  Future<HttpResult> updateInfo({
    required String firstname,
    required String img,
    required String lastname,
    required String regionId,
    required String districsId,
  }) async {
    String url = "${_baseUrl}profile-manager/profile/update-name";
    return await _postResponse(url, {
      "img": img,
      "firstname": firstname,
      "lastname": lastname,
      "district_id": districsId,
      "region_id": regionId,
    });
  }

  Future<HttpResult> sentSlider() async {
    String url = "${_baseUrl}slider/mobile";
    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> sentRecommendedFilms() async {
    String url = "${_baseUrl}film-manager/recommended-film/index";
    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> sentCategory() async {
    String url = "${_baseUrl}film-manager/film-category/index";
    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> filterCategory(String categorySlug, String genreSlug,
      String yearfrom, String yearto, int key) async {
    String url =
        "${_baseUrl}film-manager/film-category/filter?category_key=$categorySlug&genre_key=$genreSlug&year_from=$yearfrom&year_to=$yearto&subscription_key=$key";
    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> sentGenre() async {
    String url = "${_baseUrl}film-manager/film-genre/index";
    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> sentAllFilm() async {
    String url = "${_baseUrl}film-manager/film/all";
    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> sentCollections() async {
    String url = "${_baseUrl}film-manager/supper-collection/index";
    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> sentCollectionDetails(String slug) async {
    String url =
        "${_baseUrl}film-manager/supper-collection/detail?collection_key=$slug";
    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> getFilmDetail(String slug) async {
    String url = "${_baseUrl}film-manager/film/detail?key=$slug";
    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> evaluateTheFilm(String slug, String rating) async {
    String url = "${_baseUrl}film-manager/film/rating?key=$slug&rating=$rating";
    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> getActorDetail(String slug) async {
    String url = "${_baseUrl}film-manager/film-actor/actor?key=$slug";
    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> getRegissorDetail(String slug) async {
    String url = "${_baseUrl}film-manager/film-actor/rejisyor?key=$slug";
    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> createComment(String filmId, String comment) async {
    String url = "${_baseUrl}film-manager/film-comment/create";
    var body = {'film_id': filmId, 'comment': comment};
    return await _postResponse(url, body);
  }

  Future<HttpResult> getFilmComments(String slug) async {
    String url = "${_baseUrl}film-manager/film-comment/comments?key=$slug";
    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> getHomeCategory() async {
    String url = "${_baseUrl}film-manager/film-category/home-category";
    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> addFavorite(String filmSlug) async {
    String url = "${_baseUrl}film-manager/favorite-film/create?key=$filmSlug";
    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> getSeasonsList(String slug) async {
    String url = "${_baseUrl}film-manager/film/seasons?key=$slug";
    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> getSerialsList(String slug, int page) async {
    String url =
        "${_baseUrl}film-manager/film/season-parts?season=$slug&page=$page&per-page=18";
    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> searchFilms(String searchText) async {
    String url = "${_baseUrl}film-manager/film/index?name=$searchText";
    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> likeTap(String slug) async {
    String url = "${_baseUrl}film-manager/film/like?slug=$slug";
    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> dislikeTap(String slug) async {
    String url = "${_baseUrl}film-manager/film/dislike?slug=$slug";
    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> changeUserName({
    required String firstname,
    required String lastname,
  }) async {
    String url = "${_baseUrl}profile-manager/profile/update-name";
    return await _postResponse(url, {
      "firstname": firstname,
      "lastname": lastname,
    });
  }

  Future<HttpResult> getActiveRates() async {
    String url = "${_baseUrl}profile-manager/profile/current-tariff";
    return await _postResponse(url, {});
  }

  Future<HttpResult> watchVideo(String slug) async {
    String url = "${_baseUrl}film-manager/film/watch?key=$slug";
    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> getRegions() async {
    String url = "${_baseUrl}settings/regions";
    return await _postResponse(url, {});
  }

  Future<HttpResult> getDistrics(int id) async {
    String url = "${_baseUrl}settings/districts?region_id=$id";
    return await _postResponse(url, {});
  }

  //
  // Future<HttpResult> getBrends() async {
  //   String url = "${_baseUrl}driver-manager/car-brend/index";
  //   return await _postResponse(url, {});
  // }

  // Future<HttpResult> createOrder(Order order) async {
  //   String url = "${_baseUrl}order-manager/order/create";
  //   return await _postResponse(url, {
  //     "district1_id": order.district1_id,
  //     "district2_id": order.district2_id,
  //     "tariff_id": order.tariff_id,
  //     "passenger_count": order.passenger_count,
  //     "type": order.type,
  //     "comment": order.comment,
  //     "is_another_person_order": order.is_another_person_order,
  //     "is_conditioner": order.is_conditioner,
  //     "is_load": order.is_load,
  //     "load_id": order.load_id,
  //     "date": order.date,
  //   });
  // }
  //
  Future<HttpResult> getUser() async {
    String url = "${_baseUrl}profile-manager/profile/index";
    return await _postResponse(url, {});
  }

  Future<HttpResult> getSaved() async {
    String url = "${_baseUrl}film-manager/favorite-film/index";
    return await _postResponse(url, {});
  }

  Future<HttpResult> getTarifs() async {
    String url = "${_baseUrl}tariff-manager/tariff/index";
    return await _postResponse(url, {});
  }

  Future<HttpResult> getTransactions() async {
    String url = "${_baseUrl}profile-manager/profile/transactions";
    return await _postResponse(url, {});
  }

  Future<HttpResult> getHistory() async {
    String url = "${_baseUrl}profile-manager/profile/my-tariffs";
    return await _postResponse(url, {});
  }

  Future<HttpResult> getTransactionsSearch(String from, String to) async {
    String url =
        "${_baseUrl}profile-manager/profile/transaction-search?started_at=$from&finished_at=$to";
    return await _postResponse(url, {});
  }

  Future<HttpResult> getStoriesSearch(String from, String to) async {
    String url =
        "${_baseUrl}profile-manager/profile/tariff-search?started_at=$from&finished_at=$to";
    return await _postResponse(url, {});
  }

  Future<HttpResult> getCollectionsSearch(
      String slug, String from, String to, int subscriptionKey) async {
    String url =
        "${_baseUrl}film-manager/supper-collection/detail?collection_key=$slug&year_from=$from&year_to=$to&subscription_key=$subscriptionKey";

    var body = {};
    return await _postResponse(url, body);
  }

  Future<HttpResult> logout(String deviceid) async {
    String url = "${_baseUrl}left-menu-manager/user-device/logout";
    return await _postResponse(url, {'device_id': deviceid});
  }

  Future<HttpResult> subscripeTarif(int id) async {
    String url = "${_baseUrl}tariff-manager/tariff/purchase";
    return await _postResponse(url, {
      "id": id.toString(),
    });
  }

  Future<HttpResult> payTarifs(String price, String serviceName) async {
    String url =
        "${_baseUrl}tariff-manager/payment/get-$serviceName-url?amount=$price";
    return await _postResponse(url, {});
  }
}
