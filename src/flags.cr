class Cr6502::Flags
  SHIFTS = { 
    carry: 0,
    zero: 1,
    interrupt: 2,
    decimal: 3,
    brk: 4,
    _blank: 5, # always 1
    overflow: 6,
    negative: 7,
  }

  getter value
  
  def initialize(@value = 32_u8)
  end

  def to_s
    String::Builder.build do |b|
      SHIFTS.keys.each { |name| b << "#{name.to_s[0]}: #{self.[name]}, " }
    end
  end

  def []?(flagname) : Bool
   self.[flagname] == 1 
  end

  def [](flagname) : UInt8
   (@value >> SHIFTS[flagname]) & 1 
  end

  def set(flagname) : Nil
    @value |= (1 << SHIFTS[flagname])
  end

  def clear(flagname) : Nil
    @value &= ~(1 << SHIFTS[flagname])
  end
end

