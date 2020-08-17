@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::ROR
  include Cr6502::A

  # ROR (ROtate Right)
  # Affects Flags: N Z C
  # MODE           SYNTAX       HEX LEN TIM
  # Accumulator   ROR A         $6A  1   2
  # Zero Page     ROR $44       $66  2   5
  # Zero Page,X   ROR $44,X     $76  2   6
  # Absolute      ROR $4400     $6E  3   6
  # Absolute,X    ROR $4400,X   $7E  3   7
  # ROR shifts all bits right one position. The Carry is shifted into bit 7 and the original bit 0 is shifted into the Carry. 

 @[OpCode(
    h: 0x6A, m: "accumulator", len: 1, cycles: 2)]
  def ror_immidiate : Nil
  end

  @[OpCode(
    h: 0x66, m: "zeropage", len: 2, cycles: 5)]
  def ror_zeropage(arg) : Nil
  end

  @[OpCode(
    h: 0x76, m: "zeropagex", len: 2, cycles: 6)]
  def ror_zeropagex(arg) : Nil
  end

  @[OpCode(
    h: 0x6E, m: "absolute", len: 3, cycles: 6)]
  def ror_absolute(arg) : Nil
  end

  @[OpCode(
    h: 0x7E, m: "absolutex", len: 3, cycles: 4, ex: 1)]
  def ror_absolutex(arg) : Nil
  end
end
