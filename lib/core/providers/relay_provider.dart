import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'relay_provider.g.dart';

/// Relay connection status
enum RelayStatus { online, connecting, disconnected, error }

/// Relay model
class Relay {
  final String id;
  final String name;
  final String url;
  final RelayStatus status;

  const Relay({
    required this.id,
    required this.name,
    required this.url,
    required this.status,
  });

  Relay copyWith({String? id, String? name, String? url, RelayStatus? status}) {
    return Relay(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      status: status ?? this.status,
    );
  }
}

/// Relay provider
@riverpod
class Relays extends _$Relays {
  @override
  List<Relay> build() {
    return _getDummyRelays();
  }

  /// Add a new relay
  void addRelay(Relay relay) {
    state = [...state, relay];
  }

  /// Remove a relay
  void removeRelay(String id) {
    state = state.where((relay) => relay.id != id).toList();
  }

  /// Update relay status
  void updateStatus(String id, RelayStatus status) {
    state = state.map((relay) {
      if (relay.id == id) {
        return relay.copyWith(status: status);
      }
      return relay;
    }).toList();
  }

  /// Dummy relay data
  List<Relay> _getDummyRelays() {
    return [
      const Relay(
        id: '1',
        name: 'Nostr.wine',
        url: 'wss://relay.nostr.wine',
        status: RelayStatus.online,
      ),
      const Relay(
        id: '2',
        name: 'Damus',
        url: 'wss://relay.damus.io',
        status: RelayStatus.online,
      ),
      const Relay(
        id: '3',
        name: 'Nostr.band',
        url: 'wss://relay.nostr.band',
        status: RelayStatus.connecting,
      ),
      const Relay(
        id: '4',
        name: 'Primal',
        url: 'wss://relay.primal.net',
        status: RelayStatus.online,
      ),
      const Relay(
        id: '5',
        name: 'Snort',
        url: 'wss://relay.snort.social',
        status: RelayStatus.disconnected,
      ),
      const Relay(
        id: '6',
        name: 'Nostr.mom',
        url: 'wss://relay.nostr.mom',
        status: RelayStatus.error,
      ),
      const Relay(
        id: '7',
        name: 'Nostr.build',
        url: 'wss://relay.nostr.build',
        status: RelayStatus.online,
      ),
      const Relay(
        id: '8',
        name: 'Eden',
        url: 'wss://eden.nostr.land',
        status: RelayStatus.online,
      ),
    ];
  }
}
