require "./annotations.cr"
require "./instructions.cr"
require "./flags.cr"

require "./memory_utils.cr"
require "./flags_utils.cr"

class Cr6502::CPU
  include Cr6502::FlagsUtils
  include Cr6502::MemoryUtils
  include Cr6502::Instructions

  property accumulator
  getter registers

  def initialize(@memory : Array(UInt8), @start : UInt16)
    @pc = @start
    @sp = 255_u8
    @accumulator = 0_u8
    @flags = Flags.new 
    
    @registers = Hash(Symbol, UInt8).new
    @registers[:x] = 0_u8
    @registers[:y] = 0_u8
  end

  def running?
    @memory[@pc.to_u32 + 1]?
  end

  def cycle!
    opcode = @memory[@pc]
    exec opcode
  end

  macro finished
    {% def_modules = @type.ancestors.select { |a| a.annotation(Cr6502::A::DefinitionModule) } %}
    def exec(opcode)
      case opcode
      {% begin %}
        {% for def_mod in def_modules %}
          {% for def_met in def_mod.methods.select { |m| m.annotation(Cr6502::A::Realization) } %}
            {% realization_a = def_met.annotation(Cr6502::A::Realization) %}
            {% for hex, data in realization_a[:for] %}
              when {{ hex }}
                {% if data[:len] == 1 %}
                  puts "[#{@pc.to_s(16)}], #{ {{ realization_a[:name] }} }, code: #{opcode.to_s(16)}, [a: #{accumulator.to_s(16)}, x: #{registers[:x].to_s(16)}, y: #{registers[:y].to_s(16)}], [sp: #{@sp}, v: #{stack_peek.to_s(16)}] [#{@flags.to_s}]"
                  {{ def_met.name.id }}
                {% else %}
                  %mem = read_addr_for({{ data[:m] }})
                  puts "[#{@pc.to_s(16)}], #{ {{ realization_a[:name] }} }, code: #{opcode.to_s(16)}, addr: #{%mem.to_s(16)}, [a: #{accumulator.to_s(16)}, x: #{registers[:x].to_s(16)}, y: #{registers[:y].to_s(16)}],  [sp: #{@sp}, v: #{stack_peek.to_s(16)}] [#{@flags.to_s}]"
                  {{ def_met.name.id }}(%mem)
                {% end %}

                {% unless data[:br] %}
                  @pc += {{ data[:len] }}
                {% end %}
            {% end %}
          {% end %}
        {% end %}
      {% end %}
      else
        raise "invalid opcode: #{opcode.to_s(16)} at [#{@pc.to_s(16)}]"
        @pc += 1
      end
    end
  end
end
