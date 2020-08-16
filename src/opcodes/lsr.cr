@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::LSR
  include Cr6502::A

  # LSR (Logical Shift Right)
  # Affects Flags: N Z C
  # MODE           SYNTAX       HEX LEN TIM
  # Accumulator   LSR A         $4A  1   2
  # Zero Page     LSR $44       $46  2   5
  # Zero Page,X   LSR $44,X     $56  2   6
  # Absolute      LSR $4400     $4E  3   6
  # Absolute,X    LSR $4400,X   $5E  3   7
  # LSR shifts all bits right one position. 0 is shifted into bit 7 and the original bit 0 is shifted into the Carry.

  @[OpCode(
    h: 0x4A, m: "immidiate", len: 1, cycles: 2)]
  def lsr_immidiate : Nil
  end

  @[OpCode(
    h: 0x46, m: "zeropage", len: 2, cycles: 5)]
  def lsr_zeropage : Nil
  end

  @[OpCode(
    h: 0x56, m: "zeropagex", len: 2, cycles: 6)]
  def lsr_zeropagex : Nil
  end

  @[OpCode(
    h: 0x4E, m: "absolute", len: 3, cycles: 6)]
  def lsr_absolute : Nil
  end

  @[OpCode(
    h: 0x5E, m: "absolutex", len: 3, cycles: 7)]
  def lsr_absolutex : Nil
  end
end
