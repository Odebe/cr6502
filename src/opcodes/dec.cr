@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::DEC
  include Cr6502::A

  # DEC (DECrement memory)
  # Affects Flags: N Z

  # MODE           SYNTAX       HEX LEN TIM
  # Zero Page     DEC $44       $C6  2   5
  # Zero Page,X   DEC $44,X     $D6  2   6
  # Absolute      DEC $4400     $CE  3   6
  # Absolute,X    DEC $4400,X   $DE  3   7

  @[OpCode(
    h: 0xC6, m: "zeropage", len: 2, cycles: 5)]
  def dec_zeropage(arg) : Nil
  end

  @[OpCode(
    h: 0xD6, m: "zeropagex", len: 2, cycles: 6)]
  def dec_zeropagex(arg) : Nil
  end

  @[OpCode(
    h: 0xCE, m: "absolute", len: 3, cycles: 6)]
  def dec_absolute(arg) : Nil
  end

  @[OpCode(
    h: 0xDE, m: "absolutex", len: 3, cycles: 7)]
  def dec_absolutex(arg) : Nil
  end
end
