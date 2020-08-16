@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::REG
  include Cr6502::A

  # Register Instructions
  # Affect Flags: N Z
  # These instructions are implied mode, have a length of one byte and require two machine cycles.
  # MNEMONIC                 HEX
  # TAX (Transfer A to X)    $AA
  # TXA (Transfer X to A)    $8A
  # DEX (DEcrement X)        $CA
  # INX (INcrement X)        $E8
  # TAY (Transfer A to Y)    $A8
  # TYA (Transfer Y to A)    $98
  # DEY (DEcrement Y)        $88
  # INY (INcrement Y)        $C8

  @[OpCode(
    h: 0xAA, m: "implied", len: 1, cycles: 2)]
  def tax_implied : Nil
  end

  @[OpCode(
    h: 0x8A, m: "implied", len: 1, cycles: 2)]
  def txa_implied : Nil
  end

  @[OpCode(
    h: 0xCA, m: "implied", len: 1, cycles: 2)]
  def dex_implied : Nil
  end

  @[OpCode(
    h: 0xE8, m: "implied", len: 1, cycles: 2)]
  def inx_implied : Nil
  end

  @[OpCode(
    h: 0xA8, m: "implied", len: 1, cycles: 2)]
  def tay_implied : Nil
  end

  @[OpCode(
    h: 0x98, m: "implied", len: 1, cycles: 2)]
  def tya_implied : Nil
  end

  @[OpCode(
    h: 0x88, m: "implied", len: 1, cycles: 2)]
  def dey_implied : Nil
  end

  @[OpCode(
    h: 0xC8, m: "implied", len: 1, cycles: 2)]
  def iny_implied : Nil
  end
end
