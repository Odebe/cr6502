@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::RTI
  include Cr6502::A

  # RTI (ReTurn from Interrupt)
  # Affects Flags: all
  # MODE           SYNTAX       HEX LEN TIM
  # Implied       RTI           $40  1   6
  # RTI retrieves the Processor Status Word (flags) and the Program Counter from the stack in that order (interrupts push the PC first and then the PSW).
  # Note that unlike RTS, the return address on the stack is the actual address rather than the address-1.

 @[OpCode(
    h: 0x40, m: "implied", len: 1, cycles: 6)]
  def rti_implied : Nil
  end
end
