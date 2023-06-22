import 'package:dio/dio.dart';

import '../object/movie.dart';
import 'api_app.dart';

class CallAPI {
  Future<List<Movie>> getAiringTodayMovies(bool load) async {
    try {
      // load = true;

      Response response =
          await Dio().get(APIService.apiKey + APIService.airingToday,
              options: Options(headers: {
                'Authorization': APIService.token,
              }));
      if (response.statusCode == 200) {
        final jsonBody = response.data;
        var results = jsonBody['results'];
        List<Movie> movies = [];
        for (var movie in results) {
          movies.add(
            Movie.fromJson(movie),
          );
        }
        load = false;
        return movies;
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Failed to make API call.');
    }
  }

  Future<List<Movie>> getPopularMovies(bool load) async {
    try {
      load = true;

      Response response =
          await Dio().get(APIService.apiKey + APIService.popular,
              options: Options(headers: {
                'Authorization': APIService.token,
              }));
      if (response.statusCode == 200) {
        final jsonBody = response.data;
        var results = jsonBody['results'];
        List<Movie> movies = [];
        for (var movie in results) {
          movies.add(
            Movie.fromJson(movie),
          );
        }
        load = false;
        return movies;
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Failed to make API call.');
    }
  }

  Future<List<Movie>> getTopRatedMovies(bool load) async {
    try {
      load = true;

      Response response =
          await Dio().get(APIService.apiKey + APIService.topRated,
              options: Options(headers: {
                'Authorization': APIService.token,
              }));
      if (response.statusCode == 200) {
        final jsonBody = response.data;
        var results = jsonBody['results'];
        List<Movie> movies = [];
        for (var movie in results) {
          movies.add(
            Movie.fromJson(movie),
          );
        }
        load = false;
        return movies;
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Failed to make API call.');
    }
  }

  Future<List<Movie>> getOnTheAirMovies(bool load) async {
    try {
      load = true;

      Response response =
          await Dio().get(APIService.apiKey + APIService.onTheAir,
              options: Options(headers: {
                'Authorization': APIService.token,
              }));
      if (response.statusCode == 200) {
        final jsonBody = response.data;
        var results = jsonBody['results'];
        List<Movie> movies = [];
        for (var movie in results) {
          movies.add(
            Movie.fromJson(movie),
          );
        }
        load = false;
        return movies;
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Failed to make API call.');
    }
  }
}
