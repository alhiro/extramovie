import 'package:extramile_movie/constants.dart';
import 'package:extramile_movie/model/detail_discover_model.dart';
import 'package:extramile_movie/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GetDetailDiscover extends StatefulWidget {
  final MovieDetailDiscover? discover;

  const GetDetailDiscover({Key? key, required this.discover}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GetDetailDiscoverState createState() => _GetDetailDiscoverState();
}

class _GetDetailDiscoverState extends State<GetDetailDiscover> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {}

  @override
  Widget build(BuildContext context) {
    return DiscoverCard(
      title: widget.discover?.originalTitle ?? "",
      backdrop: widget.discover?.backdropPath ?? "",
      releaseDate: widget.discover?.releaseDate ?? "",
      vote: widget.discover?.voteAverage ?? 0,
      overview: widget.discover?.overview ?? "",
    );
  }
}

class DiscoverCard extends StatelessWidget {
  const DiscoverCard({
    Key? key,
    required this.title,
    required this.backdrop,
    required this.releaseDate,
    required this.vote,
    required this.overview,
  }) : super(key: key);

  final String title;
  final String backdrop;
  final String releaseDate;
  final double vote;
  final String overview;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        child: Column(
          children: [
            backdrop != ""
                ? Column(
                    children: [
                      CachedNetworkImage(
                        height: 250,
                        width: double.infinity,
                        imageUrl: themoviedbImageURLW500 + backdrop,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => _renderShimmerImg(),
                      ),
                      Container(
                        padding:
                            EdgeInsets.all(getProportionateScreenWidth(15)),
                        child: Row(
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
                            const SizedBox(width: 5),
                            Text(
                              (vote / 2).toStringAsFixed(1),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            Text(
                              "Release Date: $releaseDate",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(15)),
                        child: Column(
                          children: [
                            Text(
                              title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              overview,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Image.asset('assets/images/cover.jpg'),
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
