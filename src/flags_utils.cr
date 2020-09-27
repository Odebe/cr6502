module Cr6502::FlagsUtils
  {% for m in [:negative, :overflow, :brk, :decimal, :interrupt, :zero, :carry] %}
    def {{ m.id }}_flag?
      @flags[{{ m }}]?
    end

    def {{ m.id }}_flag
      @flags[{{ m }}]
    end
  {% end %}
  
  def set_negative(tmp) : Nil
    (tmp >> 7) & 1 == 1 ? @flags.set(:negative) : @flags.clear(:negative)
  end

  def set_zero(tmp) : Nil
    (tmp & 0xFF) == 0 ? @flags.set(:zero) : @flags.clear(:zero)
  end

  def set_carry_u16(tmp : UInt16) : Nil
    (tmp >> 8) > 0 ? @flags.set(:carry) : @flags.clear(:carry)
  end

  def set_carry_u8(tmp : UInt8) : Nil
    ((tmp >> 7) & 1 )== 1 ? @flags.set(:carry) : @flags.clear(:carry)
  end

  def set_adc_overflow(old_acc, acc, mem) : Nil
    if ((~(old_acc ^ mem)) & (old_acc ^ acc) & 0x80) == 0
      @flags.set(:overflow)
    else
      @flags.clear(:overflow) 
    end
  end
end
