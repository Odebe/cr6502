@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::AND
  include Cr6502::A

  # AND (bitwise AND with accumulator)
  # Affects Flags: N Z

  # MODE           SYNTAX       HEX LEN TIM
  # Immediate     AND #$44      $29  2   2
  # Zero Page     AND $44       $25  2   3
  # Zero Page,X   AND $44,X     $35  2   4
  # Absolute      AND $4400     $2D  3   4
  # Absolute,X    AND $4400,X   $3D  3   4+
  # Absolute,Y    AND $4400,Y   $39  3   4+
  # Indirect,X    AND ($44,X)   $21  2   6
  # Indirect,Y    AND ($44),Y   $31  2   5+
  # + add 1 cycle if page boundary crossed

  @[OpCode(
    h: 0x29, m: "immidiate", len: 2, cycles: 2)]
  def and_immidiate(arg) : Nil
  end

  @[OpCode(
    h: 0x25, m: "zeropage", len: 2, cycles: 3)]
  def and_zeropage(arg) : Nil
  end

  @[OpCode(
    h: 0x35, m: "zeropagex", len: 2, cycles: 4)]
  def and_zeropagex(arg) : Nil
  end

  @[OpCode(
    h: 0x2D, m: "absolute", len: 2, cycles: 4)]
  def and_absolute(arg) : Nil
  end

  @[OpCode(
    h: 0x3D, m: "absolutex", len: 3, cycles: 4, ex: 1)]
  def and_absolutex(arg) : Nil
  end

  @[OpCode(
    h: 0x39, m: "absolutey", len: 3, cycles: 4, ex: 1)]
  def and_absolutey(arg) : Nil
  end

  @[OpCode(
    h: 0x21, m: "indirectx", len: 2, cycles: 6, ex: 1)]
  def and_indirectx(arg) : Nil
  end

  @[OpCode(
    h: 0x31, m: "indirecty", len: 2, cycles: 5, ex: 1)]
  def and_indirecty(arg) : Nil
  end
end

