import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_provider.g.dart';

/// Feed item model
class FeedItem {
  final String id;
  final String displayName;
  final String content;
  final DateTime timestamp;
  final List<String>? imageUrls;
  final int commentCount;
  final int likeCount;
  final int zapCount;

  const FeedItem({
    required this.id,
    required this.displayName,
    required this.content,
    required this.timestamp,
    this.imageUrls,
    this.commentCount = 0,
    this.likeCount = 0,
    this.zapCount = 0,
  });

  FeedItem copyWith({
    String? id,
    String? displayName,
    String? content,
    DateTime? timestamp,
    List<String>? imageUrls,
    int? commentCount,
    int? likeCount,
    int? zapCount,
  }) {
    return FeedItem(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      imageUrls: imageUrls ?? this.imageUrls,
      commentCount: commentCount ?? this.commentCount,
      likeCount: likeCount ?? this.likeCount,
      zapCount: zapCount ?? this.zapCount,
    );
  }
}

/// Feed state notifier
@riverpod
class Feed extends _$Feed {
  @override
  List<FeedItem> build() {
    // Return dummy data for now
    return _getDummyFeed();
  }

  /// Refresh feed
  Future<void> refresh() async {
    // TODO: Implement actual Nostr feed fetching
    state = _getDummyFeed();
  }

  /// Load more items
  Future<void> loadMore() async {
    // TODO: Implement pagination
  }

  /// Like a post
  void likePost(String postId) {
    state = state.map((item) {
      if (item.id == postId) {
        return item.copyWith(likeCount: item.likeCount + 1);
      }
      return item;
    }).toList();
  }

  /// Zap a post
  void zapPost(String postId, int amount) {
    state = state.map((item) {
      if (item.id == postId) {
        return item.copyWith(zapCount: item.zapCount + amount);
      }
      return item;
    }).toList();
  }

  /// Dummy feed data
  List<FeedItem> _getDummyFeed() {
    return [
      FeedItem(
        id: '1',
        displayName: 'Alice',
        content:
            'Just published my first note on Nostr! This decentralized protocol is amazing. No censorship, no algorithms, just pure freedom. 🚀',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        imageUrls: [
          'assets/dummy_images/dummy_image_1.png',
          'assets/dummy_images/dummy_image_3.png',
        ],
        commentCount: 5,
        likeCount: 23,
        zapCount: 1200,
      ),
      FeedItem(
        id: '2',
        displayName: 'Bob',
        content:
            'GM everyone! ☀️ What are you building today? I\'m working on a new Nostr client.',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        commentCount: 12,
        likeCount: 45,
        zapCount: 3500,
      ),
      FeedItem(
        id: '3',
        displayName: 'Charlie',
        content:
            'The future of social media is decentralized. Nostr proves that we don\'t need big tech companies to connect with each other.',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        imageUrls: ['assets/dummy_images/dummy_image_2.png'],
        commentCount: 8,
        likeCount: 67,
        zapCount: 5000,
      ),
      FeedItem(
        id: '4',
        displayName: 'Diana',
        content:
            'Just zapped my first sats on Nostr! This is the future of value transfer on social media. ⚡',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        commentCount: 15,
        likeCount: 89,
        zapCount: 8900,
      ),
      FeedItem(
        id: '5',
        displayName: 'Eve',
        content:
            'Love how Nostr gives me full control over my data. My keys, my content, my rules. This is what the internet should have been from the start.',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        commentCount: 20,
        likeCount: 102,
        zapCount: 12000,
      ),
      FeedItem(
        id: '6',
        displayName: 'Frank',
        content:
            'Building on Nostr is so much fun! The community is incredibly supportive and the protocol is elegant in its simplicity.',
        timestamp: DateTime.now().subtract(const Duration(days: 7)),
        commentCount: 7,
        likeCount: 34,
        zapCount: 2100,
      ),
      FeedItem(
        id: '7',
        displayName: 'Grace',
        content:
            'Excited to see more apps being built on Nostr. The ecosystem is growing fast! 🔥',
        timestamp: DateTime.now().subtract(const Duration(days: 14)),
        commentCount: 3,
        likeCount: 18,
        zapCount: 500,
      ),
    ];
  }
}
