@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::CMP
  include Cr6502::A

  # CMP (CoMPare accumulator)
  # Affects Flags: N Z C
  # MODE           SYNTAX       HEX LEN TIM
  # Immediate     CMP #$44      $C9  2   2
  # Zero Page     CMP $44       $C5  2   3
  # Zero Page,X   CMP $44,X     $D5  2   4
  # Absolute      CMP $4400     $CD  3   4
  # Absolute,X    CMP $4400,X   $DD  3   4+
  # Absolute,Y    CMP $4400,Y   $D9  3   4+
  # Indirect,X    CMP ($44,X)   $C1  2   6
  # Indirect,Y    CMP ($44),Y   $D1  2   5+

  @[OpCode(
    h: 0xC9, m: "immediate", len: 2, cycles: 2)]
  def cmp_immediate(arg) : Nil
  end

  @[OpCode(
    h: 0xC5, m: "zeropage", len: 2, cycles: 3)]
  def cmp_zeropage(arg) : Nil
  end

  @[OpCode(
    h: 0xD5, m: "zeropagex", len: 2, cycles: 4)]
  def cmp_zeropagex(arg) : Nil
  end

  @[OpCode(
    h: 0xCD, m: "absolute", len: 3, cycles: 4)]
  def cmp_absolute(arg) : Nil
  end

  @[OpCode(
    h: 0xDD, m: "absolutex", len: 2, cycles: 4, ext: 1)]
  def cmp_absolutex(arg) : Nil
  end

  @[OpCode(
    h: 0xD9, m: "absolutey", len: 3, cycles: 4, ext: 1)]
  def cmp_absolutey(arg) : Nil
  end

  @[OpCode(
    h: 0xC1, m: "indirectx", len: 2, cycles: 6)]
  def cmp_indirectx(arg) : Nil
  end

  @[OpCode(
    h: 0xD1, m: "indirecty", len: 2, cycles: 5, ext: 1)]
  def cmp_indirecty(arg) : Nil
  end
end
