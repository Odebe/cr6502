@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::INC
  include Cr6502::A

  # Affects Flags: N Z
  # MODE           SYNTAX       HEX LEN TIM
  # Zero Page     INC $44       $E6  2   5
  # Zero Page,X   INC $44,X     $F6  2   6
  # Absolute      INC $4400     $EE  3   6
  # Absolute,X    INC $4400,X   $FE  3   7

  @[OpCode(
    h: 0xE6, m: "zeropage", len: 2, cycles: 5)]
  def inc_zeropage(arg) : Nil
  end

  @[OpCode(
    h: 0xF6, m: "zeropagex", len: 2, cycles: 6)]
  def inc_zeropagex(arg) : Nil
  end

  @[OpCode(
    h: 0xEE, m: "absolute", len: 3, cycles: 6)]
  def inc_absolute(arg) : Nil
  end

  @[OpCode(
    h: 0xFE, m: "absolutex", len: 3, cycles: 7)]
  def inc_absolutex(arg) : Nil
  end
end
