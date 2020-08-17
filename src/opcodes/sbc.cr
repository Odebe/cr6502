@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::SBC
  include Cr6502::A

  # SBC (SuBtract with Carry)
  # Affects Flags: N V Z C
  # MODE           SYNTAX       HEX LEN TIM
  # Immediate     SBC #$44      $E9  2   2
  # Zero Page     SBC $44       $E5  2   3
  # Zero Page,X   SBC $44,X     $F5  2   4
  # Absolute      SBC $4400     $ED  3   4
  # Absolute,X    SBC $4400,X   $FD  3   4+
  # Absolute,Y    SBC $4400,Y   $F9  3   4+
  # Indirect,X    SBC ($44,X)   $E1  2   6
  # Indirect,Y    SBC ($44),Y   $F1  2   5+
  # + add 1 cycle if page boundary crossed

  @[OpCode(
    h: 0xE9, m: "immidiate", len: 2, cycles: 2)]
  def sbc_immidiate(arg) : Nil
  end

  @[OpCode(
    h: 0xE5, m: "zeropage", len: 2, cycles: 3)]
  def sbc_zeropage(arg) : Nil
  end

  @[OpCode(
    h: 0xF5, m: "zeropagex", len: 2, cycles: 4)]
  def sbc_zeropagex(arg) : Nil
  end

  @[OpCode(
    h: 0xED, m: "absolute", len: 3, cycles: 4)]
  def sbc_absolute(arg) : Nil
  end

  @[OpCode(
    h: 0xFD, m: "absolutex", len: 3, cycles: 4, ex: 1)]
  def sbc_absolutex(arg) : Nil
  end

  @[OpCode(
    h: 0xF9, m: "absolutey", len: 3, cycles: 4, ex: 1)]
  def sbc_absolutey(arg) : Nil
  end

  @[OpCode(
    h: 0xE1, m: "indirectx", len: 2, cycles: 6)]
  def sbc_indirectx(arg) : Nil
  end

  @[OpCode(
    h: 0xF1, m: "indirecty", len: 2, cycles: 5, ex: 1)]
  def sbc_indirecty(arg) : Nil
  end
end
