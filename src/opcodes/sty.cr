@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::STY
  include Cr6502::A

  # STY (STore Y register)
  # Affects Flags: none
  # MODE           SYNTAX       HEX LEN TIM
  # Zero Page     STY $44       $84  2   3
  # Zero Page,X   STY $44,X     $94  2   4
  # Absolute      STY $4400     $8C  3   4

  @[OpCode(
    h: 0x84, m: "zeropage", len: 2, cycles: 3)]
  def sty_zeropage: Nil
  end

  @[OpCode(
    h: 0x94, m: "zeropagey", len: 2, cycles: 4)]
  def sty_zeropagey : Nil
  end

  @[OpCode(
    h: 0x8C, m: "absolute", len: 3, cycles: 4)]
  def sty_absolute : Nil
  end
end
