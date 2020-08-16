@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::CPY
  include Cr6502::A

  # CPY (ComPare Y register)
  # Affects Flags: N Z C

  # MODE           SYNTAX       HEX LEN TIM
  # Immediate     CPY #$44      $C0  2   2
  # Zero Page     CPY $44       $C4  2   3
  # Absolute      CPY $4400     $CC  3   4

  @[OpCode(
    h: 0xC0, m: "immediate", len: 2, cycles: 2)]
  def cpy_immediate : Nil
  end

  @[OpCode(
    h: 0xC4, m: "zeropage", len: 2, cycles: 3)]
  def cpy_zeropage : Nil
  end

  @[OpCode(
    h: 0xCC, m: "absolute", len: 3, cycles: 4)]
  def cpy_absolute : Nil
  end
end
