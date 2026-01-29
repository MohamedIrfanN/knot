import 'package:flutter/material.dart';
import 'package:knot/core/theme/app_colors.dart';
import 'package:knot/core/widgets/app_drawer.dart';
import 'package:knot/core/widgets/custom_app_bar.dart';
import 'package:knot/core/widgets/feed_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: const CustomAppBar(),
      drawer: const AppDrawer(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.backgroundDark,
        child: ListView.builder(
          itemCount: _dummyFeedData.length,
          itemBuilder: (context, index) {
            final feed = _dummyFeedData[index];
            return FeedCard(
              displayName: feed['displayName'] as String,
              content: feed['content'] as String,
              timestamp: feed['timestamp'] as DateTime,
              imageUrls: feed['imageUrls'] as List<String>?,
              commentCount: feed['commentCount'] as int,
              likeCount: feed['likeCount'] as int,
              zapCount: feed['zapCount'] as int,
              onComment: () {
                // TODO: Implement comment
              },
              onLike: () {
                // TODO: Implement like
              },
              onZap: () {
                // TODO: Implement zap
              },
            );
          },
        ),
      ),
    );
  }
}

// Dummy feed data for testing
final List<Map<String, dynamic>> _dummyFeedData = [
  {
    'displayName': 'Alice',
    'content':
        'Just published my first note on Nostr! This decentralized protocol is amazing. No censorship, no algorithms, just pure freedom. 🚀',
    'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
    'imageUrls': [
      'assets/dummy_images/dummy_image_1.png',
      'assets/dummy_images/dummy_image_3.png',
    ],
    'commentCount': 5,
    'likeCount': 23,
    'zapCount': 1200,
  },
  {
    'displayName': 'Bob',
    'content':
        'GM everyone! ☀️ What are you building today? I\'m working on a new Nostr client.',
    'timestamp': DateTime.now().subtract(const Duration(hours: 5)),
    'commentCount': 12,
    'likeCount': 45,
    'zapCount': 3500,
  },
  {
    'displayName': 'Charlie',
    'content':
        'The future of social media is decentralized. Nostr proves that we don\'t need big tech companies to connect with each other.',
    'timestamp': DateTime.now().subtract(const Duration(days: 1)),
    'imageUrls': ['assets/dummy_images/dummy_image_2.png'],
    'commentCount': 8,
    'likeCount': 67,
    'zapCount': 5000,
  },
  {
    'displayName': 'Diana',
    'content':
        'Just zapped my first sats on Nostr! This is the future of value transfer on social media. ⚡',
    'timestamp': DateTime.now().subtract(const Duration(days: 2)),
    'commentCount': 15,
    'likeCount': 89,
    'zapCount': 8900,
  },
  {
    'displayName': 'Eve',
    'content':
        'Love how Nostr gives me full control over my data. My keys, my content, my rules. This is what the internet should have been from the start.',
    'timestamp': DateTime.now().subtract(const Duration(days: 3)),
    'commentCount': 20,
    'likeCount': 102,
    'zapCount': 12000,
  },
  {
    'displayName': 'Frank',
    'content':
        'Building on Nostr is so much fun! The community is incredibly supportive and the protocol is elegant in its simplicity.',
    'timestamp': DateTime.now().subtract(const Duration(days: 7)),
    'commentCount': 7,
    'likeCount': 34,
    'zapCount': 2100,
  },
  {
    'displayName': 'Grace',
    'content':
        'Excited to see more apps being built on Nostr. The ecosystem is growing fast! 🔥',
    'timestamp': DateTime.now().subtract(const Duration(days: 14)),
    'commentCount': 3,
    'likeCount': 18,
    'zapCount': 500,
  },
];
