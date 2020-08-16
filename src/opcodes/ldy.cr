@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::LDY
  include Cr6502::A

  # LDY (LoaD Y register)
  # Affects Flags: N Z

  # MODE           SYNTAX       HEX LEN TIM
  # Immediate     LDY #$44      $A0  2   2
  # Zero Page     LDY $44       $A4  2   3
  # Zero Page,X   LDY $44,X     $B4  2   4
  # Absolute      LDY $4400     $AC  3   4
  # Absolute,X    LDY $4400,X   $BC  3   4+
  # + add 1 cycle if page boundary crossed

  @[OpCode(
    h: 0xA0, m: "immidiate", len: 2, cycles: 2)]
  def ldy_immidiate : Nil
  end

  @[OpCode(
    h: 0xA4, m: "zeropage", len: 2, cycles: 3)]
  def ldy_zeropage : Nil
  end

  @[OpCode(
    h: 0xB4, m: "zeropagex", len: 2, cycles: 4)]
  def ldy_zeropagex : Nil
  end

  @[OpCode(
    h: 0xAc, m: "absolute", len: 3, cycles: 4)]
  def ldy_absolute : Nil
  end

  @[OpCode(
    h: 0xBC, m: "absolutex", len: 3, cycles: 4, ex: 1)]
  def ldy_absolutex : Nil
  end
end
