module Cr6502::Opcodes::ROR    
  #  ORA  OR Memory with Accumulator
  #  A OR M -> A                      N Z C I D V
  #                                   + + - - - -
  #  addressing    assembler    opc  bytes  cyles
  #  --------------------------------------------
  #  immidiate     ORA #oper     09    2     2
  #  zeropage      ORA oper      05    2     3
  #  zeropage,X    ORA oper,X    15    2     4
  #  absolute      ORA oper      0D    3     4
  #  absolute,X    ORA oper,X    1D    3     4*
  #  absolute,Y    ORA oper,Y    19    3     4*
  #  (indirect,X)  ORA (oper,X)  01    2     6
  #  (indirect),Y  ORA (oper),Y  11    2     5*

  # @[Opcodes::A(0x09, "ORA", "IMM", 2, 2, 0)]
  def ora_immidiate
  end

  def ora_zeropage
  end

  def ora_zeropagex
  end
end
