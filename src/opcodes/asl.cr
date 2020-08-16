@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::ASL
  include Cr6502::A

  # ASL (Arithmetic Shift Left)
  # Affects Flags: N Z C

  # MODE           SYNTAX       HEX LEN TIM
  # Accumulator   ASL A         $0A  1   2
  # Zero Page     ASL $44       $06  2   5
  # Zero Page,X   ASL $44,X     $16  2   6
  # Absolute      ASL $4400     $0E  3   6
  # Absolute,X    ASL $4400,X   $1E  3   7
  
  @[OpCode(
    h: 0x0A, m: "accumulator", len: 1, cycles: 2)]
  def asl_accumulator : Nil
  end

  @[OpCode(
    h: 0x06, m: "zeropage", len: 2, cycles: 5)]
  def asl_zeropage : Nil
  end

  @[OpCode(
    h: 0x16, m: "zeropagex", len: 2, cycles: 6)]
  def asl_zeropagex : Nil
  end

  @[OpCode(
    h: 0x0E, m: "absolute", len: 3, cycles: 6)]
  def asl_absolute : Nil
  end

  @[OpCode(
    h: 0x1E, m: "absolutex", len: 3, cycles: 7)]
  def asl_absolutex : Nil
  end  
end
