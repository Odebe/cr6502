@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::STK
  include Cr6502::A

  # Stack Instructions
  # These instructions are implied mode, have a length of one byte and require machine cycles as indicated. The "PuLl" operations are known as "POP" on most other microprocessors. With the 6502, the stack is always on page one ($100-$1FF) and works top down.

  # MNEMONIC                        HEX TIM
  # TXS (Transfer X to Stack ptr)   $9A  2
  # TSX (Transfer Stack ptr to X)   $BA  2
  # PHA (PusH Accumulator)          $48  3
  # PLA (PuLl Accumulator)          $68  4
  # PHP (PusH Processor status)     $08  3
  # PLP (PuLl Processor status)     $28  4

  @[OpCode(
    h: 0x9A, m: "implied", len: 1, cycles: 2)]
  def txs_implied : Nil
  end

  @[OpCode(
    h: 0xBA, m: "implied ", len: 1, cycles: 2)]
  def tsx_implied  : Nil
  end

  @[OpCode(
    h: 0x48, m: "implied", len: 1, cycles: 3)]
  def pha_implied : Nil
  end

  @[OpCode(
    h: 0x68, m: "implied", len: 1, cycles: 4)]
  def pla_implied : Nil
  end

  @[OpCode(
    h: 0x08, m: "implied", len: 1, cycles: 3)]
  def php_implied : Nil
  end

  @[OpCode(
    h: 0x28, m: "implied", len: 1, cycles: 4)]
  def plp_implied : Nil
  end
end

