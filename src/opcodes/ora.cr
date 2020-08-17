@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::ORA
  include Cr6502::A

  # ORA (bitwise OR with Accumulator)
  # Affects Flags: N Z
  # MODE           SYNTAX       HEX LEN TIM
  # Immediate     ORA #$44      $09  2   2
  # Zero Page     ORA $44       $05  2   3
  # Zero Page,X   ORA $44,X     $15  2   4
  # Absolute      ORA $4400     $0D  3   4
  # Absolute,X    ORA $4400,X   $1D  3   4+
  # Absolute,Y    ORA $4400,Y   $19  3   4+
  # Indirect,X    ORA ($44,X)   $01  2   6
  # Indirect,Y    ORA ($44),Y   $11  2   5+
  # + add 1 cycle if page boundary crossed

  @[OpCode(
    h: 0x09, m: "immidiate", len: 2, cycles: 2)]
  def ora_immidiate(arg) : Nil
  end

  @[OpCode(
    h: 0x05, m: "zeropage", len: 2, cycles: 3)]
  def ora_zeropage(arg) : Nil
  end

  @[OpCode(
    h: 0x15, m: "zeropagex", len: 2, cycles: 4)]
  def ora_zeropagex(arg) : Nil
  end

  @[OpCode(
    h: 0x0D, m: "absolute", len: 3, cycles: 4)]
  def ora_absolute(arg) : Nil
  end

  @[OpCode(
    h: 0x1D, m: "absolutex", len: 3, cycles: 4, ex: 1)]
  def ora_absolutex(arg) : Nil
  end

  @[OpCode(
    h: 0x19, m: "absolutey", len: 3, cycles: 4, ex: 1)]
  def ora_absolutey(arg) : Nil
  end

  @[OpCode(
    h: 0x01, m: "indirectx", len: 2, cycles: 6)]
  def ora_indirectx(arg) : Nil
  end

  @[OpCode(
    h: 0x11, m: "indirecty", len: 2, cycles: 5, ex: 1)]
  def ora_indirecty(arg) : Nil
  end
end
