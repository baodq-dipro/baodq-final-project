import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:food_recipe_app/pages/home_screen/detail_screen.dart';
import '../../define/custom_page_indicator.dart';
import '../../object/movie.dart';
import '../../api_app/api_app.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  static const routeNamed = "/HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> _movies = [];

  bool isLoad = true;

  int _selectedIndex = 0;
  int _currentPageIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  final List<String> _buttonNames = [
    'Airing Today',
    'Popular',
    'Top Rated',
    'On The Air',
  ];

  Future<List<Movie>> getAiringTodayMovies() async {
    try {
      isLoad = true;
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
        isLoad = false;
        return movies;
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Failed to make API call.');
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    try {
      isLoad = true;
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
        isLoad = false;
        return movies;
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Failed to make API call.');
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    try {
      isLoad = true;
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
        isLoad = false;
        return movies;
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Failed to make API call.');
    }
  }

  Future<List<Movie>> getOnTheAirMovies() async {
    try {
      isLoad = true;

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
        isLoad = false;
        return movies;
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Failed to make API call.');
    }
  }

  void _handleTap(int index) {
    switch (index) {
      case 0:
        getAiringTodayMovies().then((movies) {
          setState(() {
            _movies = movies;
          });
        });
        break;
      case 1:
        getPopularMovies().then((movies) {
          setState(() {
            _movies = movies;
          });
        });
        break;
      case 2:
        getTopRatedMovies().then((movies) {
          setState(() {
            _movies = movies;
          });
        });
        break;
      case 3:
        getOnTheAirMovies().then((movies) {
          setState(() {
            _movies = movies;
          });
        });
        break;
      default:
    }
  }

  void _automaticallyImage() {
    Timer.periodic(
      const Duration(seconds: 10),
      (Timer timer) {
        if (_currentPageIndex < _movies.length - 1) {
          _currentPageIndex++;
        } else {
          _currentPageIndex = 0;
        }
        _pageController.animateToPage(
          _currentPageIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    getAiringTodayMovies().then((movies) {
      setState(() {
        isLoad = false;
        _movies = movies;
      });
    });
    _automaticallyImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(
        int.parse("0xff242A32"),
      ),
      body: ListView(
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 42,
                      ),
                      child: Center(
                        child: SizedBox(
                          height: 300.0,
                          child: PageView.builder(
                            pageSnapping: true,
                            controller: _pageController,
                            itemCount: _movies.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => DetailScreen(id: _movies[index].id,
                                        
                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: isLoad == true
                                    ? const CircularProgressIndicator()
                                    : Image.network(
                                        APIService.apiStringImage +
                                            _movies[index].poster,
                                        fit: BoxFit.fill),
                              );
                            },
                            onPageChanged: (int index) {
                              setState(() {
                                _currentPageIndex = index;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 10,
                      child: Container(
                        alignment: Alignment.center,
                        child: CustomPageIndicator(
                          totalCount: _movies.length,
                          currentIndex: _currentPageIndex,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _buttonNames.length,
                    itemBuilder: (BuildContext context, int index) {
                      Color buttonColor = _selectedIndex == index
                          ? Colors.blueGrey
                          : Colors.grey;
                      return Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                            ),
                            onPressed: () {
                              _handleTap(index);
                              _currentPageIndex = 0;
                              _pageController.jumpToPage(0);
                              _selectedIndex = index;
                            },
                            child: Text(
                              _buttonNames[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _movies.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Image.network(
                          APIService.apiStringImage + _movies[index].poster,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

