// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$feedHash() => r'52b80fefd6616819787b61fa73638c664f7f31e5';

/// Feed state notifier
///
/// Copied from [Feed].
@ProviderFor(Feed)
final feedProvider = AutoDisposeNotifierProvider<Feed, List<FeedItem>>.internal(
  Feed.new,
  name: r'feedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$feedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Feed = AutoDisposeNotifier<List<FeedItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
