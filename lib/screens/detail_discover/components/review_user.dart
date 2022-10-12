import 'package:extramile_movie/constants.dart';
import 'package:extramile_movie/model/review_user_model.dart';
import 'package:extramile_movie/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class GetReviewUser extends StatefulWidget {
  final List<MovieReviewUser> reviews;

  const GetReviewUser({Key? key, required this.reviews}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GetReviewUserState createState() => _GetReviewUserState();
}

class _GetReviewUserState extends State<GetReviewUser> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {}

  final Future<String> _calculationData = Future<String>.delayed(
    const Duration(milliseconds: 500),
    () => 'Data Review Loaded',
  );

  @override
  Widget build(BuildContext context) {
    return widget.reviews.isEmpty
        ? Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(20)),
            child: _renderShimmerReviewUser())
        : Column(
            children: [
              const Text(
                "Review's",
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
                              return ReviewUserCard(
                                author: widget.reviews[index].author,
                                content: widget.reviews[index].content,
                                createdDate: widget.reviews[index].createdDate,
                                press: () {},
                              );
                            },
                            separatorBuilder: (context, index) => const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child:
                                  Divider(thickness: 1, color: Colors.white30),
                            ),
                            itemCount: widget.reviews.length,
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
                        children = <Widget>[_renderShimmerReviewUser()];
                      }
                      return Column(
                        children: children,
                      );
                    }),
              ),
            ],
          );
  }

  Widget _renderShimmerReviewUser() {
    return Shimmer.fromColors(
      baseColor: AppColors.silver,
      highlightColor: AppColors.mercury,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 20 / 5,
          crossAxisCount: 1,
          mainAxisSpacing: 15,
          crossAxisSpacing: 30,
        ),
        itemCount: widget.reviews.isNotEmpty ? widget.reviews.length : 15,
        itemBuilder: (BuildContext context, int index) {
          return Container(height: 1, width: 1, color: Colors.white);
        },
      ),
    );
  }
}

class ReviewUserCard extends StatelessWidget {
  const ReviewUserCard({
    Key? key,
    required this.author,
    required this.content,
    required this.createdDate,
    required this.press,
  }) : super(key: key);

  final String author;
  final String content;
  final String createdDate;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  author,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Text(
                  DateFormat('yyyy-MM-dd HH:mm:ss')
                      .format(DateTime.parse(createdDate.toString())),
                  textAlign: TextAlign.left,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(11)),
            Text(
              content,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
            )
          ],
        ),
      ),
    );
  }
}
