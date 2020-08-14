require "./annotations.cr"
require "./opcodes/adc.cr"

class Cr6502::CPU
  include Cr6502::Opcodes::ADC

  macro finished
    {% def_modules = @type.ancestors.select { |a| a.annotation(Cr6502::A::DefinitionModule) } %}
    def exec(opcode)
      case opcode
      {% begin %}
        {% for def_mod in def_modules %}
          {% mod_a = def_mod.annotation(Cr6502::A::DefinitionModule) %}
          {% for def_met in def_mod.methods.select { |m| m.annotation(Cr6502::A::OpCode) } %}
            {% met_a = def_met.annotation(Cr6502::A::OpCode) %}
            when {{ met_a[:h] }}
              {{ mod_a[:code].id }}_{{ met_a[:m].id }}
          {% end %}
        {% end %}
      {% end %}
      end
    end
  end
end
