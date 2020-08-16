@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::JMP
  include Cr6502::A

  # JMP (JuMP)
  # Affects Flags: none

  # MODE           SYNTAX       HEX LEN TIM
  # Absolute      JMP $5597     $4C  3   3
  # Indirect      JMP ($5597)   $6C  3   5

  @[OpCode(
    h: 0x4C, m: "absolute", len: 3, cycles: 3)]
  def jmp_absolute : Nil
  end

  @[OpCode(
    h: 0x6C, m: "indirect", len: 3, cycles: 5)]
  def jmp_indirect : Nil
  end
end
