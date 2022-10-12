import 'package:extramile_movie/constants.dart';
import 'package:extramile_movie/controller/discover_controller.dart';
import 'package:extramile_movie/model/discover_model.dart';
import 'package:extramile_movie/screens/detail_discover/detail_discover_screen.dart';
import 'package:extramile_movie/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GetDiscover extends StatefulWidget {
  final int? genreId;

  const GetDiscover({Key? key, required this.genreId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GetDiscoverState createState() => _GetDiscoverState();
}

class _GetDiscoverState extends State<GetDiscover> {
  final DiscoverController discoverController = DiscoverController.to;

  List<MovieDiscover> listData = [];

  int currentPage = 1;
  int page = 1;
  bool? isRefresh;

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await discoverController.handleGetDiscoverByGenreEndless(
        widget.genreId, page = 1, isRefresh = true);

    if (mounted) {
      setState(() {
        listData = discoverController.discoversGenre;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: SmartRefresher(
          controller: refreshController,
          enablePullUp: true,
          enablePullDown: true,
          header: const MaterialClassicHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = const Text("Muat lebih banyak...");
              } else if (mode == LoadStatus.loading) {
                body = const CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = const Text("Gagal tampilkan data! Coba lagi!");
              } else if (mode == LoadStatus.canLoading) {
                body = const Text("Lepas untuk menampilkan data");
              } else {
                body = const Text("Tidak ada data lagi");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          onRefresh: () async {
            currentPage = 1;

            await discoverController.handleGetDiscoverByGenreEndless(
                widget.genreId, page = currentPage, isRefresh = true);

            if (listData.isNotEmpty) {
              if (mounted) {
                setState(() {
                  listData = discoverController.discoversGenre;
                });
              }
              refreshController.refreshCompleted();
            } else {
              refreshController.refreshFailed();
            }
          },
          onLoading: () async {
            currentPage++;

            await discoverController.handleGetDiscoverByGenreEndless(
                widget.genreId, page = currentPage, isRefresh = false);

            if (listData.isNotEmpty) {
              if (mounted) {
                setState(() {
                  listData = discoverController.discoversGenre;
                });
              }
              refreshController.loadComplete();
            } else {
              refreshController.loadFailed();
            }
          },
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(0)),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildListDiscover(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Padding _buildListDiscover() {
    return listData.isEmpty
        ? Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(20)),
            child: _renderShimmerDiscover())
        : Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(20)),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 92 / 150,
                crossAxisCount: 2,
                mainAxisSpacing: 30,
                crossAxisSpacing: 30,
              ),
              itemCount: listData.length,
              itemBuilder: (context, index) {
                return DiscoverCard(
                  title: listData[index].title,
                  poster: listData[index].posterPath,
                  genre: listData[index].genreIds,
                  popularity: listData[index].popularity,
                  vote: listData[index].voteAverage,
                  release: listData[index].releaseDate,
                  press: () {
                    Navigator.pushNamed(
                      context,
                      DiscoverDetailScreen.routeName,
                      arguments: DiscoverDetailArguments(
                          listDiscover: listData[index]),
                    );
                  },
                );
              },
            ));
  }

  Widget _renderShimmerDiscover() {
    return Shimmer.fromColors(
      baseColor: AppColors.logan,
      highlightColor: AppColors.selago,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 92 / 150,
          crossAxisCount: 2,
          mainAxisSpacing: 30,
          crossAxisSpacing: 30,
        ),
        itemCount: listData.isNotEmpty ? listData.length : 15,
        itemBuilder: (BuildContext context, int index) {
          return Container(height: 11, width: 11, color: Colors.white);
        },
      ),
    );
  }
}

class DiscoverCard extends StatelessWidget {
  const DiscoverCard({
    Key? key,
    required this.title,
    required this.poster,
    required this.genre,
    required this.popularity,
    required this.vote,
    required this.release,
    required this.press,
  }) : super(key: key);

  final String title;
  final String poster;
  final List genre;
  final double popularity;
  final double vote;
  final String release;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                child: Hero(
                  tag: title,
                  child: poster.isNotEmpty
                      ? CachedNetworkImage(
                          height: double.infinity,
                          width: double.infinity,
                          imageUrl: themoviedbImageURLW300 + poster,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(11),
                            ),
                          ),
                          placeholder: (context, url) => _renderShimmerImg(),
                        )
                      : Container(
                          padding:
                              EdgeInsets.all(getProportionateScreenWidth(15)),
                          height: getProportionateScreenWidth(0),
                          width: getProportionateScreenWidth(0),
                          decoration: BoxDecoration(
                            color: AppColors.logan,
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                ),
              ),
            ),
            Row(
              children: [
                RatingBar.builder(
                  initialRating: vote / 2,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 15.0,
                  unratedColor: AppColors.supernova.withAlpha(50),
                  itemPadding: const EdgeInsets.symmetric(
                      vertical: 3.0, horizontal: 1.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: AppColors.supernova,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                const Spacer(),
                Text(
                  (vote / 2).toStringAsFixed(1),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 9),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderShimmerImg() {
    return Shimmer.fromColors(
      baseColor: AppColors.logan,
      highlightColor: AppColors.selago,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
        ),
      ),
    );
  }
}
