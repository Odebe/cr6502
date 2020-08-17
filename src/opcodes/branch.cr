@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::Branch
  include Cr6502::A

  # Branch Instructions
  # Affect Flags: none

  # MNEMONIC                       HEX
  # BPL (Branch on PLus)           $10
  # BMI (Branch on MInus)          $30
  # BVC (Branch on oVerflow Clear) $50
  # BVS (Branch on oVerflow Set)   $70
  # BCC (Branch on Carry Clear)    $90
  # BCS (Branch on Carry Set)      $B0
  # BNE (Branch on Not Equal)      $D0
  # BEQ (Branch on EQual)          $F0

  # A branch not taken requires two machine cycles. Add one if the branch is taken and add one more if the branch crosses a page boundary.
  
  @[OpCode(
    h: 0x10, m: "relative", len: 2, cycles: 1, branch: true)]
  def bpl : Nil
  end

  @[OpCode(
    h: 0x30, m: "relative", len: 2, cycles: 1, branch: true)]
  def bmi : Nil
  end

  @[OpCode(
    h: 0x50, m: "relative", len: 2, cycles: 1, branch: true)]
  def bvc : Nil
  end

  @[OpCode(
    h: 0x70, m: "relative", len: 2, cycles: 1, branch: true)]
  def bvs : Nil
  end

  @[OpCode(
    h: 0x90, m: "relative", len: 2, cycles: 1, branch: true)]
  def bcc : Nil
  end

  @[OpCode(
    h: 0xB0, m: "relative", len: 2, cycles: 1, branch: true)]
  def bcs : Nil
  end

  @[OpCode(
    h: 0xD0, m: "relative", len: 2, cycles: 1, branch: true)]
  def bne : Nil
  end

  @[OpCode(
    h: 0xF0, m: "relative", len: 2, cycles: 1, branch: true)]
  def beq : Nil
  end
end
