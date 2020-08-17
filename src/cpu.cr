require "./annotations.cr"
require "./opcodes/*"

class Cr6502::CPU  
  include Cr6502::Opcodes::ADC
  include Cr6502::Opcodes::AND
  include Cr6502::Opcodes::ASL
  include Cr6502::Opcodes::BIT
  include Cr6502::Opcodes::BRK
  include Cr6502::Opcodes::CMP
  include Cr6502::Opcodes::CPX
  include Cr6502::Opcodes::CPY
  include Cr6502::Opcodes::DEC
  include Cr6502::Opcodes::EOR
  include Cr6502::Opcodes::INC
  include Cr6502::Opcodes::JMP
  include Cr6502::Opcodes::JSR
  include Cr6502::Opcodes::LDA
  include Cr6502::Opcodes::LDX
  include Cr6502::Opcodes::LDY
  include Cr6502::Opcodes::LSR
  include Cr6502::Opcodes::NOP
  include Cr6502::Opcodes::ORA
  include Cr6502::Opcodes::REG
  include Cr6502::Opcodes::ROL
  include Cr6502::Opcodes::ROR
  include Cr6502::Opcodes::RTI
  include Cr6502::Opcodes::RTS
  include Cr6502::Opcodes::SBC
  include Cr6502::Opcodes::STA
  include Cr6502::Opcodes::STK
  include Cr6502::Opcodes::STX
  include Cr6502::Opcodes::STY
  include Cr6502::Opcodes::Branch



  def initialize(@memory : Array(UInt8), @start : UInt16)
    @pc = @start
  end

  def running?
    @memory[@pc + 1]?
  end

  def cycle!
    opcode = read_opcode
    exec opcode
  end

  macro read_opcode
    @memory[@pc]
  end

  macro read_arg(num)
    {% len = @def.annotation(Cr6502::A::OpCode)[:len] %}
    {% if len == nil || num <= 0 || num > len %}
      {% raise "Opcode has no arguments or wrong argument num" %}
    {% else %}
       @memory[@pc + {{ len }}]
    {% end %}
  end

  macro finished
    {% def_modules = @type.ancestors.select { |a| a.annotation(Cr6502::A::DefinitionModule) } %}
    def exec(opcode)
      case opcode
      {% begin %}
        {% for def_mod in def_modules %}
          {% for def_met in def_mod.methods.select { |m| m.annotation(Cr6502::A::OpCode) } %}
            {% met_a = def_met.annotation(Cr6502::A::OpCode) %}
            when {{ met_a[:h] }}
              args = begin
                %a = [] of UInt8
                {% for i in 0..(met_a[:len] - 1) %}
                  %a << @memory[@pc + {{ i }}]
                {% end %}
                %a
              end

              puts "[#{@pc.to_s(16)}] #{ {{ def_met.name.stringify }} }, #{args}"
              
              @pc += {{ met_a[:len] }}
          {% end %}
        {% end %}
      {% end %}
      else
        puts "[#{@pc.to_s(16)}] ignoring #{opcode.to_s(16)}"
        @pc += 1
      end
    end
  end
end
