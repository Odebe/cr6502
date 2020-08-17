@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::CPX
  include Cr6502::A

  # CPX (ComPare X register)
  # Affects Flags: N Z C

  # MODE           SYNTAX       HEX LEN TIM
  # Immediate     CPX #$44      $E0  2   2
  # Zero Page     CPX $44       $E4  2   3
  # Absolute      CPX $4400     $EC  3   4

  # Operation and flag results are identical to equivalent mode accumulator CMP ops.

  @[OpCode(
    h: 0xE0, m: "immediate", len: 2, cycles: 2)]
  def cpx_immediate(arg) : Nil
  end

  @[OpCode(
    h: 0xE4, m: "zeropage", len: 2, cycles: 3)]
  def cpx_zeropage(arg) : Nil
  end

  @[OpCode(
    h: 0xEC, m: "absolute", len: 3, cycles: 4)]
  def cpx_absolute(arg) : Nil
  end
end
