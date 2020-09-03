require "./annotations.cr"
require "./instructions.cr"
require "./memory_utils.cr"

# require "./opcodes/*"

class Cr6502::CPU
  include Cr6502::MemoryUtils
  include Cr6502::Instructions

  def initialize(@memory : Array(UInt8), @start : UInt16)
    @pc = @start

    @acc = 0_u8
    @status = { negative: 0, overflow: 0, brk: 0, decimal: 0, interrupt: 0, zero: 0, carry: 0 }
    @registers = { x: 0_u8, y: 0_u8 }
  end

  def running?
    @memory[@pc + 1]?
  end

  def cycle!
    opcode = @memory[@pc]
    exec opcode
  end

  macro puk
    {% def_modules = @type.ancestors.select { |a| a.annotation(Cr6502::A::DefinitionModule) } %}
    def exec(opcode)
      {% opcodes = 0 %}
      {% methods = 0 %}
      case opcode
      {% begin %}
        {% for def_mod in def_modules %}
          {% for def_met in def_mod.methods.select { |m| m.annotation(Cr6502::A::Realization) } %}
            {% realization_a = def_met.annotation(Cr6502::A::Realization) %}
            {% methods += 1 %}
            {% for hex, data in realization_a[:for] %}
              when {{ hex }}
                {% opcodes += 1 %}
                {% if data[:len] == 1 %}
                  puts "#{@pc}, #{ {{ realization_a[:name] }} }, #{opcode}"
                  # {{ def_met.name.id }}
                {% else %}
                  addr = find_addr_for({{ data[:m] }})
                  puts "#{@pc}, #{ {{ realization_a[:name] }} }, #{opcode}, addr: #{addr}, mem: #{@memory[addr]}"
                  # {{ def_met.name.id }}(%addr)
                {% end %}

                @pc += {{ data[:len] }}
            {% end %}
          {% end %}
        {% end %}
      {% end %}
      else
        puts "[#{@pc.to_s(16)}] ignoring #{opcode.to_s(16)}"
        @pc += 1
      end
      puts "opcodes count {{ opcodes }}"
      puts "opcodes count {{ methods }} / 56"
    end
  end
end

Cr6502::CPU.puk
