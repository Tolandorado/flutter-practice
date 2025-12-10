/// Object equipable by a [Character].
abstract class Item {}

mixin HasDamage {
  late int _damage;

  int get getDamage => _damage;
}

mixin HasDefence {
  late int _defence;

  int get getDefence => _defence;
}

mixin EquipableHands {}
mixin EquipableHat {}
mixin EquipableTorso {}
mixin EquipableLegs {}
mixin EquipableShoes {}

/// Entity equipping [Item]s.
class Character {
  Item? leftHand;
  Item? rightHand;
  Item? hat;
  Item? torso;
  Item? legs;
  Item? shoes;

  /// Returns all the [Item]s equipped by this [Character].
  Iterable<Item> get equipped =>
      [leftHand, rightHand, hat, torso, legs, shoes].whereType<Item>();

  /// Returns the total damage of this [Character].
  int get damage {
    return equipped.whereType<HasDamage>().fold(
      0,
      (sum, item) => sum + item.getDamage,
    );
  }

  /// Returns the total defense of this [Character].
  int get defense {
    return equipped.whereType<HasDefence>().fold(
      0,
      (sum, item) => sum + item.getDefence,
    );
  }

  /// Equips the provided [item], meaning putting it to the corresponding slot.
  ///
  /// If there's already a slot occupied, then throws a [OverflowException].
  void equip(Item item) {
    switch (item) {
      case EquipableHands _:
        leftHand ??= item;
        if (leftHand == item) {
          break;
        }
        rightHand ??= item;
        if (rightHand == item) {
          break;
        }
        throw OverflowException();
      case EquipableHat _:
        hat ??= item;
        if (hat != item) {
          throw OverflowException();
        }
        break;
      case EquipableTorso _:
        torso ??= item;
        if (torso != item) {
          throw OverflowException();
        }
        break;
      case EquipableLegs _:
        legs ??= item;
        if (legs != item) {
          throw OverflowException();
        }
        break;
      case EquipableShoes _:
        shoes ??= item;
        if (shoes != item) {
          throw OverflowException();
        }
        break;
      default:
        throw ArgumentError('Unsupported item type');
    }
  }
}

/// [Exception] indicating there's no place left in the [Character]'s slot.
class OverflowException implements Exception {}

class Sword extends Item with HasDamage, EquipableHands {
  Sword(int damage) {
    this._damage = damage;
  }
}

class Spear extends Item with HasDamage, EquipableHands {
  Spear(int damage) {
    this._damage = damage;
  }
}

class Hat extends Item with HasDefence, EquipableHat {
  Hat(int defence) {
    this._defence = defence;
  }
}

class Torso extends Item with HasDefence, EquipableTorso {
  Torso(int defence) {
    this._defence = defence;
  }
}

void main() {
  // Implement mixins to differentiate [Item]s into separate categories to be
  // equipped by a [Character]: weapons should have some damage property, while
  // armor should have some defense property.
  //
  // [Character] can equip weapons into hands, helmets onto hat, etc.
  Character character = Character();
  character.equip(Sword(20));
  character.equip(Spear(10));
  character.equip(Hat(15));
  character.equip(Torso(20));

  print('Total damage: ${character.damage}');
  print('Total defence: ${character.defense}');
}
