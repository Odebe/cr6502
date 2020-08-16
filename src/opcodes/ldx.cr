@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::LDX
  include Cr6502::A

  # LDX (LoaD X register)
  # Affects Flags: N Z
  # MODE           SYNTAX       HEX LEN TIM
  # Immediate     LDX #$44      $A2  2   2
  # Zero Page     LDX $44       $A6  2   3
  # Zero Page,Y   LDX $44,Y     $B6  2   4
  # Absolute      LDX $4400     $AE  3   4
  # Absolute,Y    LDX $4400,Y   $BE  3   4+
  # + add 1 cycle if page boundary crossed

  @[OpCode(
    h: 0xA2, m: "immidiate", len: 2, cycles: 2)]
  def ldx_immidiate : Nil
  end

  @[OpCode(
    h: 0xA6, m: "zeropage", len: 2, cycles: 3)]
  def ldx_zeropage : Nil
  end

  @[OpCode(
    h: 0xB6, m: "zeropagex", len: 2, cycles: 4)]
  def ldx_zeropagex : Nil
  end

  @[OpCode(
    h: 0xAe, m: "absolute", len: 3, cycles: 4)]
  def ldx_absolute : Nil
  end

  @[OpCode(
    h: 0xBE, m: "absolutey", len: 3, cycles: 4, ex: 1)]
  def ldx_absolutey: Nil
  end
end
