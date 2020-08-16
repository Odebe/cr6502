@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::STA
  include Cr6502::A

  # STA (STore Accumulator)
  # Affects Flags: none
  # MODE           SYNTAX       HEX LEN TIM
  # Zero Page     STA $44       $85  2   3
  # Zero Page,X   STA $44,X     $95  2   4
  # Absolute      STA $4400     $8D  3   4
  # Absolute,X    STA $4400,X   $9D  3   5
  # Absolute,Y    STA $4400,Y   $99  3   5
  # Indirect,X    STA ($44,X)   $81  2   6
  # Indirect,Y    STA ($44),Y   $91  2   6

  @[OpCode(
    h: 0x85, m: "zeropage", len: 2, cycles: 3)]
  def sta_zeropage : Nil
  end

  @[OpCode(
    h: 0x95, m: "zeropagex", len: 2, cycles: 4)]
  def sta_zeropagex : Nil
  end

  @[OpCode(
    h: 0x8D, m: "absolute", len: 3, cycles: 4)]
  def sta_absolute : Nil
  end

  @[OpCode(
    h: 0x9D, m: "absolutex", len: 3, cycles: 5)]
  def sta_absolutex : Nil
  end

  @[OpCode(
    h: 0x99, m: "absolutey", len: 3, cycles: 5)]
  def sta_absolutey: Nil
  end

  @[OpCode(
    h: 0xE1, m: "indirectx", len: 2, cycles: 6)]
  def sta_indirectx: Nil
  end

  @[OpCode(
    h: 0xF1, m: "indirecty", len: 2, cycles: 6)]
  def sta_indirecty: Nil
  end
end

