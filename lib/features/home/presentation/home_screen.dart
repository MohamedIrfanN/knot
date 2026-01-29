import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knot/core/providers/feed_provider.dart';
import 'package:knot/core/widgets/app_drawer.dart';
import 'package:knot/core/widgets/custom_app_bar.dart';
import 'package:knot/core/widgets/feed_card.dart';

/// Home screen with feed
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedItems = ref.watch(feedProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(feedProvider.notifier).refresh();
        },
        child: ListView.builder(
          itemCount: feedItems.length,
          itemBuilder: (context, index) {
            final feed = feedItems[index];
            return FeedCard(
              displayName: feed.displayName,
              content: feed.content,
              timestamp: feed.timestamp,
              imageUrls: feed.imageUrls,
              commentCount: feed.commentCount,
              likeCount: feed.likeCount,
              zapCount: feed.zapCount,
              onComment: () {
                // TODO: Implement comment
              },
              onLike: () {
                ref.read(feedProvider.notifier).likePost(feed.id);
              },
              onZap: () {
                ref.read(feedProvider.notifier).zapPost(feed.id, 100);
              },
            );
          },
        ),
      ),
    );
  }
}
