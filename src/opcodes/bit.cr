@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::BIT
  include Cr6502::A

  # BIT (test BITs)
  # Affects Flags: N V Z

  # MODE           SYNTAX       HEX LEN TIM
  # Zero Page     BIT $44       $24  2   3
  # Absolute      BIT $4400     $2C  3   4

  @[OpCode(
    h: 0x24, m: "zeropage", len: 2, cycles: 3)]
  def bit_zeropage(arg) : Nil
  end

  @[OpCode(
    h: 0x2C, m: "absolute", len: 3, cycles: 4)]
  def bit_absolute(arg) : Nil
  end
end