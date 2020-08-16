@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::RTS
  include Cr6502::A

  # RTS (ReTurn from Subroutine)
  # Affects Flags: none
  # MODE           SYNTAX       HEX LEN TIM
  # Implied       RTS           $60  1   6
  # RTS pulls the top two bytes off the stack (low byte first) and transfers program control to that address+1. It is used, as expected, to exit a subroutine invoked via JSR which pushed the address-1.
  # RTS is frequently used to implement a jump table where addresses-1 are pushed onto the stack and accessed via RTS eg. to access the second of four routines:

 @[OpCode(
    h: 0x60, m: "implied", len: 1, cycles: 6)]
  def rts_implied : Nil
  end
end
