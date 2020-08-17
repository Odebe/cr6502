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

  macro finished
    {% def_modules = @type.ancestors.select { |a| a.annotation(Cr6502::A::DefinitionModule) } %}
    def exec(opcode)
      case opcode
      {% begin %}
        {% for def_mod in def_modules %}
          {% for def_met in def_mod.methods.select { |m| m.annotation(Cr6502::A::OpCode) } %}
            {% met_a = def_met.annotation(Cr6502::A::OpCode) %}
            when {{ met_a[:h] }}
              arg = begin
                {% if met_a[:len] == 2 %}
                  @memory[@pc + 1]
                {% elsif met_a[:len] == 3 %}
                  (@memory[@pc + 1].to_u16 << 8) | @memory[@pc + 2]
                {% end %}
              end
              
              # A		....	Accumulator	 	OPC A	 	operand is AC (implied single byte instruction)
              # abs		....	absolute	 	OPC $LLHH	 	operand is address $HHLL *
              # abs,X		....	absolute, X-indexed	 	OPC $LLHH,X	 	operand is address; effective address is address incremented by X with carry **
              # abs,Y		....	absolute, Y-indexed	 	OPC $LLHH,Y	 	operand is address; effective address is address incremented by Y with carry **
              # #		....	immediate	 	OPC #$BB	 	operand is byte BB
              # impl		....	implied	 	OPC	 	operand implied
              # ind		....	indirect	 	OPC ($LLHH)	 	operand is address; effective address is contents of word at address: C.w($HHLL)
              # X,ind		....	X-indexed, indirect	 	OPC ($LL,X)	 	operand is zeropage address; effective address is word in (LL + X, LL + X + 1), inc. without carry: C.w($00LL + X)
              # ind,Y		....	indirect, Y-indexed	 	OPC ($LL),Y	 	operand is zeropage address; effective address is word in (LL, LL + 1) incremented by Y with carry: C.w($00LL) + Y
              # rel		....	relative	 	OPC $BB	 	branch target is PC + signed offset BB ***
              # zpg		....	zeropage	 	OPC $LL	 	operand is zeropage address (hi-byte is zero, address = $00LL)
              # zpg,X		....	zeropage, X-indexed	 	OPC $LL,X	 	operand is zeropage address; effective address is address incremented by X without carry **
              # zpg,Y		....	zeropage, Y-indexed	 	OPC $LL,Y	 	operand is zeropage address; effective address is address incremented by Y without carry **

              {% if met_a[:len] > 1 %}
                arg_value = begin 
                  {% case met_a[:m] %}
                  {% when "absolute" %}
                    @memory[arg]
                  {% when "absolutex" %}
                    @memory[arg + x]
                  {% when "absolutey" %}
                    @memory[arg + y]
                  {% when "immediate" %}
                    arg
                  {% when "indirect" %}
                    %hh = arg & 0x00FF
                    %ll = arg & 0xFF00
                    (%hh << 8) | (%ll >> 8)
                  {% when "indirectx" %}
                  {% when "indirecty" %}
                  {% when "relative" %}
                    @memory[@pc + arg]
                  {% when "zeropage" %}
                    @memory[arg]
                  {% when "zeropagex" %}
                    @memory[@pc + x]
                  {% when "zeropagey" %}
                    @memory[@pc + y]
                  {% end %}
                end

                {{ def_met.name.id }}({{ arg_value }})
              {% else %}
                {{ def_met.name.id }}
              {% end %}

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
