import 'package:extramile_movie/constants.dart';
import 'package:extramile_movie/model/movie_video_model.dart';
import 'package:extramile_movie/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class GetMovieVideo extends StatefulWidget {
  final List<MovieVideo> videos;

  const GetMovieVideo({Key? key, required this.videos}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GetMovieVideoState createState() => _GetMovieVideoState();
}

class _GetMovieVideoState extends State<GetMovieVideo> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {}

  final Future<String> _calculationData = Future<String>.delayed(
    const Duration(milliseconds: 500),
    () => 'Data Movie Loaded',
  );

  @override
  Widget build(BuildContext context) {
    return widget.videos.isEmpty
        ? Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(20)),
            child: _renderShimmerMovieVideo())
        : Column(
            children: [
              const Text(
                "Trailer",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white, fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
              Padding(
                padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                child: FutureBuilder<String>(
                    future: _calculationData,
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      List<Widget> children;
                      if (snapshot.hasData) {
                        children = <Widget>[
                          ListView.separated(
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return MovieVideoCard(
                                name: widget.videos[index].name,
                                keySite: widget.videos[index].key,
                                site: widget.videos[index].site,
                              );
                            },
                            separatorBuilder: (context, index) => const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child:
                                  Divider(thickness: 1, color: Colors.white30),
                            ),
                            itemCount: widget.videos.length,
                          ),
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
                        children = <Widget>[_renderShimmerMovieVideo()];
                      }
                      return Column(
                        children: children,
                      );
                    }),
              ),
            ],
          );
  }

  Widget _renderShimmerMovieVideo() {
    return Shimmer.fromColors(
      baseColor: AppColors.silver,
      highlightColor: AppColors.mercury,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 9 / 5,
          crossAxisCount: 1,
          mainAxisSpacing: 15,
          crossAxisSpacing: 30,
        ),
        itemCount: widget.videos.isNotEmpty ? widget.videos.length : 1,
        itemBuilder: (BuildContext context, int index) {
          return Container(height: 1, width: 1, color: Colors.white);
        },
      ),
    );
  }
}

class MovieVideoCard extends StatefulWidget {
  const MovieVideoCard({
    Key? key,
    required this.name,
    required this.keySite,
    required this.site,
  }) : super(key: key);

  final String name;
  final String keySite;
  final String site;

  @override
  State<MovieVideoCard> createState() => _MovieVideoCardState();
}

class _MovieVideoCardState extends State<MovieVideoCard> {
  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: widget.keySite.toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );

    return OrientationBuilder(
      builder: (context, orientation) {
        return GestureDetector(
            child: SizedBox(
                child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoutubePlayer(
              showVideoProgressIndicator: true,
              onEnded: (metaData) {},
              controller: controller,
              aspectRatio: 1.5,
              progressIndicatorColor: Colors.red,
              bottomActions: [
                const SizedBox(width: 14.0),
                CurrentPosition(),
                const SizedBox(width: 8.0),
                ProgressBar(
                  isExpanded: true,
                  colors: const ProgressBarColors(),
                ),
                RemainingDuration(),
                const PlaybackSpeedButton(),
                IconButton(
                  icon: const Icon(
                    Icons.fullscreen,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        )));
      },
    );
  }
}
