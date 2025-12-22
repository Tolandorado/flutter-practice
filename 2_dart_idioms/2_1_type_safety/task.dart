/// Value object for a user's unique identifier.
///
/// Ensures the underlying string is a valid UUIDv4 and exactly 36 characters
/// long. Construction throws a [FormatException] if the invariant is violated.
class UserId {
  /// Raw string value of the identifier.
  ///
  /// Guaranteed to be a valid UUIDv4 and 36 characters long.
  final String val;

  UserId(this.val) {
    if (val.length != 36) {
      throw const FormatException('Must be 36 characters long');
    }
    if (!RegExp(r'^[0-9a-fA-F-]+$').hasMatch(val)) {
      throw const FormatException('Must be in UUIDv4 format');
    }
  }
}

/// Value object for a user's display name.
///
/// Ensures the underlying string is 4–32 characters long and contains only
/// alphabetical letters (ASCII). Construction throws a [FormatException]
/// if validation fails.
class Name {
  /// Raw string value of the name.
  ///
  /// Guaranteed to contain only letters and be 4–32 characters long.
  final String val;

  Name(this.val) {
    if (val.length < 4 || val.length > 32) {
      throw const FormatException('Must be 4 - 32 characters long');
    }
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(val)) {
      throw const FormatException('Must contain only alphabetical letters');
    }
  }
}

/// Value object for a user's biography.
///
/// Ensures the underlying string is no longer than 255 characters.
/// Construction throws a [FormatException] if the invariant is violated.
class Bio {
  /// Raw string value of the biography.
  ///
  /// Guaranteed to be at most 255 characters long.
  final String val;

  Bio(this.val) {
    if (val.length > 255) {
      throw const FormatException('Must be no longer than 255 characters');
    }
  }
}

/// Immutable aggregate representing a user profile.
///
/// Combines a required identifier with optional name and biography. Field
/// invariants are enforced by their respective value objects.
class User {
  /// Unique user identifier.
  ///
  /// Must be a valid [UUIDv4] string of length 36.
  final UserId id;

  /// Optional display name.
  ///
  /// When present, contains only letters and is 4–32 characters long.
  final Name? name;

  /// Optional short biography.
  ///
  /// When present, is no longer than 255 characters.
  final Bio? bio;

  const User({required this.id, this.name, this.bio});
}

/// Minimal backend facade for user persistence.
///
/// In a real application, this would perform I/O (HTTP, database, etc.).
class Backend {
  /// Fetches the [User] with the given [id].
  ///
  /// Returns a [Future] that completes with the user data.
  Future<User> getUser(UserId id) async => User(id: id);

  /// Updates the user with the given [id].
  ///
  /// Returns a [Future] that completes when the update finishes.
  Future<void> putUser(UserId id, {Name? name, Bio? bio}) async {}
}

/// Application service that orchestrates user operations.
class UserService {
  /// Backend adapter used for persistence.
  final Backend backend;

  /// Creates a service with the given [backend].
  UserService(this.backend);

  /// Retrieves a user by [id].
  Future<User> get(UserId id) async => backend.getUser(id);

  /// Persists updates to [user].
  Future<void> update(User user) async =>
      backend.putUser(user.id, name: user.name, bio: user.bio);
}

void main() {
  // Do the following:
  // - fix missing explicit types;
  // - decompose the types using the newtype idiom;
  // - add documentation following the "Effective Dart: Documentation"
  //   guidelines.
}
