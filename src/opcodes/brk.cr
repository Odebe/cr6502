@[Cr6502::A::DefinitionModule]
module Cr6502::Opcodes::BRK
  include Cr6502::A

  @[OpCode(
    h: 0x00, m: "", len: 1, cycles: 0)]
  def brk : Nil
  end
end
