@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::LDA
  include Cr6502::A

  # LDA (LoaD Accumulator)
  # Affects Flags: N Z
  # MODE           SYNTAX       HEX LEN TIM
  # Immediate     LDA #$44      $A9  2   2
  # Zero Page     LDA $44       $A5  2   3
  # Zero Page,X   LDA $44,X     $B5  2   4
  # Absolute      LDA $4400     $AD  3   4
  # Absolute,X    LDA $4400,X   $BD  3   4+
  # Absolute,Y    LDA $4400,Y   $B9  3   4+
  # Indirect,X    LDA ($44,X)   $A1  2   6
  # Indirect,Y    LDA ($44),Y   $B1  2   5+
  # + add 1 cycle if page boundary crossed

  @[OpCode(
    h: 0xA9, m: "immidiate", len: 2, cycles: 2)]
  def lda_immidiate(arg) : Nil
  end

  @[OpCode(
    h: 0xA5, m: "zeropage", len: 2, cycles: 3)]
  def lda_zeropage(arg) : Nil
  end

  @[OpCode(
    h: 0xB5, m: "zeropagex", len: 2, cycles: 4)]
  def lda_zeropagex(arg) : Nil
  end

  @[OpCode(
    h: 0xAD, m: "absolute", len: 3, cycles: 4)]
  def lda_absolute(arg) : Nil
  end

  @[OpCode(
    h: 0xDB, m: "absolutex", len: 3, cycles: 4, ex: 1)]
  def lda_absolutex(arg) : Nil
  end

  @[OpCode(
    h: 0xB9, m: "absolutey", len: 3, cycles: 4, ex: 1)]
  def lda_absolutey(arg) : Nil
  end

  @[OpCode(
    h: 0xA1, m: "indirectx", len: 2, cycles: 6)]
  def lda_indirectx(arg) : Nil
  end

  @[OpCode(
    h: 0xB1, m: "indirecty", len: 2, cycles: 5, ex: 1)]
  def lda_indirecty(arg) : Nil
  end
end
