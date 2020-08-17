@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::JSR
  include Cr6502::A

  # JSR (Jump to SubRoutine)
  # Affects Flags: none
  # MODE           SYNTAX       HEX LEN TIM
  # Absolute      JSR $5597     $20  3   6
  # JSR pushes the address-1 of the next operation on to the stack before transferring program control to the following address. Subroutines are normally terminated by a RTS op code.
  
  @[OpCode(
    h: 0x20, m: "absolute", len: 3, cycles: 6, jump: true)]
  def jsr_absolute(arg) : Nil
  end
end
