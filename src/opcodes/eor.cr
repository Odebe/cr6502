@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::EOR
  include Cr6502::A

  # EOR (bitwise Exclusive OR)
  # Affects Flags: N Z

  # MODE           SYNTAX       HEX LEN TIM
  # Immediate     EOR #$44      $49  2   2
  # Zero Page     EOR $44       $45  2   3
  # Zero Page,X   EOR $44,X     $55  2   4
  # Absolute      EOR $4400     $4D  3   4
  # Absolute,X    EOR $4400,X   $5D  3   4+
  # Absolute,Y    EOR $4400,Y   $59  3   4+
  # Indirect,X    EOR ($44,X)   $41  2   6
  # Indirect,Y    EOR ($44),Y   $51  2   5+
  # + add 1 cycle if page boundary crossed

  @[OpCode(
    h: 0x49, m: "immidiate", len: 2, cycles: 2)]
  def eor_immidiate(arg) : Nil
  end

  @[OpCode(
    h: 0x45, m: "zeropage", len: 2, cycles: 3)]
  def eor_zeropage(arg) : Nil
  end

  @[OpCode(
    h: 0x55, m: "zeropagex", len: 2, cycles: 4)]
  def eor_zeropagex(arg) : Nil
  end

  @[OpCode(
    h: 0x4D, m: "absolute", len: 3, cycles: 4)]
  def eor_absolute(arg) : Nil
  end

  @[OpCode(
    h: 0x5D, m: "absolutex", len: 3, cycles: 4, ex: 1)]
  def eor_absolutex(arg) : Nil
  end

  @[OpCode(
    h: 0x59, m: "absolutey", len: 3, cycles: 4, ex: 1)]
  def eor_absolutey(arg) : Nil
  end

  @[OpCode(
    h: 0x41, m: "indirectx", len: 2, cycles: 6)]
  def eor_indirectx(arg) : Nil
  end

  @[OpCode(
    h: 0x51, m: "indirecty", len: 2, cycles: 5, ex: 1)]
  def eor_indirecty(arg) : Nil
  end
end
