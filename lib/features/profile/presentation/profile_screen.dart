import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knot/core/providers/feed_provider.dart';
import 'package:knot/core/theme/app_colors.dart';
import 'package:knot/core/widgets/feed_card.dart';
import 'package:knot/core/widgets/gradient_text.dart';
import 'package:knot/features/profile/presentation/widgets/profile_header.dart';
import 'package:knot/features/profile/presentation/widgets/stats_row.dart';

/// Profile screen showing user information and their posts
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allFeedItems = ref.watch(feedProvider);

    // TODO: Filter by actual user ID when auth is integrated
    // For now, show posts from "Alice" as example
    final userPosts = allFeedItems
        .where((item) => item.displayName == 'Alice')
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const GradientText(
          text: 'Knot',
          gradient: AppColors.primaryButtonGradient,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          // Profile Header
          SliverToBoxAdapter(
            child: ProfileHeader(
              displayName: 'Alice',
              publicKey:
                  'npub1abc123def456ghi789jkl012mno345pqr678stu901vwx234yz',
              bio:
                  'Nostr enthusiast | Building the decentralized future | Freedom advocate 🚀',
            ),
          ),

          // Stats Row
          const SliverToBoxAdapter(
            child: StatsRow(
              followingCount: 22,
              followersCount: 5,
              relaysCount: 8,
            ),
          ),

          // User Posts
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final post = userPosts[index];
              return FeedCard(
                displayName: post.displayName,
                content: post.content,
                timestamp: post.timestamp,
                imageUrls: post.imageUrls,
                commentCount: post.commentCount,
                likeCount: post.likeCount,
                zapCount: post.zapCount,
                onComment: () {
                  // TODO: Implement comment
                },
                onLike: () {
                  ref.read(feedProvider.notifier).likePost(post.id);
                },
                onZap: () {
                  ref.read(feedProvider.notifier).zapPost(post.id, 100);
                },
              );
            }, childCount: userPosts.length),
          ),
        ],
      ),
    );
  }
}
