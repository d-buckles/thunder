import 'package:flutter/material.dart';
import 'package:thunder/core/enums/media_type.dart';
import 'package:thunder/core/models/post_view_media.dart';
import 'package:thunder/shared/link_preview_card.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:lemmy/lemmy.dart';

class MediaView extends StatelessWidget {
  final Post? post;
  final PostViewMedia? postView;

  const MediaView({super.key, this.post, this.postView});

  Future<void> _launchURL(url) async {
    Uri url0 = Uri.parse(url);

    if (!await launchUrl(url0)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    if (postView == null || postView!.media.isEmpty) return Container();
    if (postView!.media.first.mediaType == MediaType.link) {
      return LinkPreviewCard(
        originURL: postView!.media.first.originalUrl,
        mediaURL: postView!.media.first.mediaUrl,
        mediaHeight: postView!.media.first.height,
        mediaWidth: postView!.media.first.width,
      );
    }
    //   return Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 8.0),
    //     child: ClipRRect(
    //       borderRadius: BorderRadius.circular(6), // Image border
    //       child: InkWell(
    //         borderRadius: BorderRadius.circular(6), // Image border
    //         child: Stack(
    //           alignment: Alignment.bottomRight,
    //           fit: StackFit.passthrough,
    //           children: [
    //             Container(
    //               color: Colors.grey.shade900,
    //               padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
    //               child: Row(
    //                 children: [
    //                   const Padding(
    //                     padding: EdgeInsets.symmetric(horizontal: 8.0),
    //                     child: Icon(
    //                       Icons.link,
    //                       color: Colors.white60,
    //                     ),
    //                   ),
    //                   Expanded(
    //                     child: Text(
    //                       postView!.media.first.originalUrl ?? '',
    //                       overflow: TextOverflow.ellipsis,
    //                       style: theme.textTheme.bodyMedium!.copyWith(
    //                         color: Colors.white60,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //         onTap: () => _launchURL(postView!.media.first.originalUrl),
    //       ),
    //     ),
    //   );
    // }

    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: postView!.media.first.mediaUrl!,
              height: postView!.media.first.height,
              width: postView!.media.first.width,
              fit: BoxFit.fitWidth,
              progressIndicatorBuilder: (context, url, downloadProgress) => Container(
                color: Colors.grey.shade900,
                child: Center(
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(value: downloadProgress.progress),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey.shade900,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                  child: InkWell(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6), // Image border
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        fit: StackFit.passthrough,
                        children: [
                          Container(
                            color: Colors.grey.shade900,
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(
                                    Icons.link,
                                    color: Colors.white60,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    post?.url ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      color: Colors.white60,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () => _launchURL(post?.url!),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
