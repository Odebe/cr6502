@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::NOP
  include Cr6502::A

  # NOP (No OPeration)
  # Affects Flags: none
  # MODE           SYNTAX       HEX LEN TIM
  # Implied       NOP           $EA  1   2
  # NOP is used to reserve space for future modifications or effectively REM out existing code.

  @[OpCode(
    h: 0xEA, m: "implied", len: 1, cycles: 2)]
  def nop_implied : Nil
  end
end
