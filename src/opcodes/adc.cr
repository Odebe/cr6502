@[Cr6502::A::DefinitionModule(code: "adc")]
module Cr6502::Opcodes::ADC
  include Cr6502::A

  # Affects Flags: N V Z C
  # MODE           SYNTAX       HEX LEN TIM
  # Immediate     ADC #$44      $69  2   2
  # Zero Page     ADC $44       $65  2   3
  # Zero Page,X   ADC $44,X     $75  2   4
  # Absolute      ADC $4400     $6D  3   4
  # Absolute,X    ADC $4400,X   $7D  3   4+
  # Absolute,Y    ADC $4400,Y   $79  3   4+
  # Indirect,X    ADC ($44,X)   $61  2   6
  # Indirect,Y    ADC ($44),Y   $71  2   5+
  # + add 1 cycle if page boundary crossed

  @[OpCode(h: 0x69, m: "immidiate", len: 2, cycles: 2)]
  def adc_immidiate
  end

  @[OpCode(h: 0x65, m: "zeropage", len: 2, cycles: 3)]
  def adc_zeropage
  end

  @[OpCode(h: 0x75, m: "zeropagex", len: 2, cycles: 4)]
  def adc_zeropagex
  end

  @[OpCode(h: 0x6D, m: "absolute", len: 3, cycles: 4)]
  def adc_absolute
  end

  @[OpCode(h: 0x7D, m: "absolutex", len: 3, cycles: 4, ex: 1)]
  def adc_absolutex
  end
end
