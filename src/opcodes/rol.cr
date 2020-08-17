@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::ROL
  include Cr6502::A

  # ROL (ROtate Left)
  # Affects Flags: N Z C
  # MODE           SYNTAX       HEX LEN TIM
  # Accumulator   ROL A         $2A  1   2
  # Zero Page     ROL $44       $26  2   5
  # Zero Page,X   ROL $44,X     $36  2   6
  # Absolute      ROL $4400     $2E  3   6
  # Absolute,X    ROL $4400,X   $3E  3   7

  @[OpCode(
    h: 0x2A, m: "immidiate", len: 1, cycles: 2)]
  def rol_accumulator : Nil
  end

  @[OpCode(
    h: 0x26, m: "zeropage", len: 2, cycles: 5)]
  def rol_zeropage(arg) : Nil
  end

  @[OpCode(
    h: 0x36, m: "zeropagex", len: 2, cycles: 6)]
  def rol_zeropagex(arg) : Nil
  end

  @[OpCode(
    h: 0x2E, m: "absolute", len: 3, cycles: 6)]
  def rol_absolute(arg) : Nil
  end

  @[OpCode(
    h: 0x3E, m: "absolutex", len: 3, cycles: 7)]
  def rol_absolutex(arg) : Nil
  end
end
