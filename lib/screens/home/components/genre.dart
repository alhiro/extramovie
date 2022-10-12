import 'package:extramile_movie/constants.dart';
import 'package:extramile_movie/controller/genre_controller.dart';
import 'package:extramile_movie/model/genre_model.dart';
import 'package:extramile_movie/screens/discover/discover_screen.dart';
import 'package:extramile_movie/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GetGenre extends StatefulWidget {
  const GetGenre({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GetGenreState createState() => _GetGenreState();
}

class _GetGenreState extends State<GetGenre> {
  final GenreController genreController = GenreController.to;

  List<MovieGenre> listData = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await genreController.handleListGenre();

    if (mounted) {
      setState(() {
        listData = genreController.genres;
      });
    }
  }

  final Future<String> _calculationData = Future<String>.delayed(
    const Duration(milliseconds: 500),
    () => 'Data Genre Loaded',
  );

  @override
  Widget build(BuildContext context) {
    return listData.isEmpty
        ? Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(20)),
            child: _renderShimmerGenre())
        : Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(20)),
            child: FutureBuilder<String>(
                future: _calculationData,
                builder: (context, AsyncSnapshot<String> snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    children = <Widget>[
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 92 / 72,
                          crossAxisCount: 3,
                          mainAxisSpacing: 3,
                          crossAxisSpacing: 30,
                        ),
                        itemCount: listData.length,
                        itemBuilder: (context, index) {
                          return GenreCard(
                            name: listData[index].name,
                            press: () {
                              Navigator.pushNamed(
                                context,
                                DiscoverScreen.routeName,
                                arguments: DiscoverArguments(
                                    listGenre: listData[index]),
                              );
                            },
                          );
                        },
                      )
                    ];
                  } else if (snapshot.hasError) {
                    children = <Widget>[
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Error: ${snapshot.error}'),
                      )
                    ];
                  } else {
                    children = <Widget>[_renderShimmerGenre()];
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: children,
                    ),
                  );
                }),
          );
  }

  Widget _renderShimmerGenre() {
    return Shimmer.fromColors(
      baseColor: AppColors.silver,
      highlightColor: AppColors.mercury,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.5,
          crossAxisCount: 3,
          mainAxisSpacing: 15,
          crossAxisSpacing: 30,
        ),
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(height: 1, width: 1, color: Colors.white);
        },
      ),
    );
  }
}

class GenreCard extends StatelessWidget {
  const GenreCard({
    Key? key,
    required this.name,
    required this.press,
  }) : super(key: key);

  final String name;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(0),
              width: getProportionateScreenWidth(0),
              decoration: BoxDecoration(
                color: AppColors.logan,
                borderRadius: BorderRadius.circular(11),
              ),
            ),
            const SizedBox(height: 7),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
