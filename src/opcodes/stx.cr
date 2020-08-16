@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::STX
  include Cr6502::A

  # STX (STore X register)
  # Affects Flags: none

  # MODE           SYNTAX       HEX LEN TIM
  # Zero Page     STX $44       $86  2   3
  # Zero Page,Y   STX $44,Y     $96  2   4
  # Absolute      STX $4400     $8E  3   4
  
  @[OpCode(
    h: 0x86, m: "zeropage", len: 2, cycles: 3)]
  def stx_zeropage: Nil
  end

  @[OpCode(
    h: 0x96, m: "zeropagey", len: 2, cycles: 4)]
  def stx_zeropagey : Nil
  end

  @[OpCode(
    h: 0x8E, m: "absolute", len: 3, cycles: 4)]
  def stx_absolute : Nil
  end
end

