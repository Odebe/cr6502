
@[Cr6502::A::DefinitionModule]
module Cr6502::Instructions
  @[Cr6502::A::Realization(name: "ADC", for: {
    0x69 => { m: "immidiate", len: 2, cycles: 2, ex: 0 },
    0x65 => { m: "zeropage",  len: 2, cycles: 3, ex: 0 },
    0x75 => { m: "zeropagex", len: 2, cycles: 4, ex: 0 },
    0x61 => { m: "indirectx", len: 2, cycles: 6, ex: 0 },
    0x71 => { m: "indirecty", len: 2, cycles: 5, ex: 1 },
    0x6D => { m: "absolute",  len: 3, cycles: 4, ex: 0 },
    0x7D => { m: "absolutex", len: 3, cycles: 4, ex: 1 },
    0x79 => { m: "absolutey", len: 3, cycles: 4, ex: 1 },})]
  def exec_adc(addr : UInt16)
    old_accumulator = accumulator
    mem = memread(addr)
    tmp = accumulator.to_u16 &+ mem.to_u16 &+ carry_flag.to_u16
       
    set_carry_u16(tmp)
    set_adc_overflow(old_accumulator, accumulator, mem)

    @accumulator = (tmp && 0xFF).to_u8
    set_zero(accumulator)
    set_negative(accumulator)
  end

  @[Cr6502::A::Realization(name: "AND", for: {
    0x29 => { m: "immidiate", len: 2, cycles: 2, ex: 0 },
    0x25 => { m: "zeropage",  len: 2, cycles: 3, ex: 0 },
    0x35 => { m: "zeropagex", len: 2, cycles: 4, ex: 0 },
    0x2D => { m: "absolute",  len: 3, cycles: 4, ex: 0 },
    0x3D => { m: "absolutex", len: 3, cycles: 4, ex: 1 },
    0x39 => { m: "absolutey", len: 3, cycles: 4, ex: 1 },
    0x21 => { m: "indirectx", len: 2, cycles: 6, ex: 0 },
    0x32 => { m: "indirecty", len: 2, cycles: 5, ex: 1 },})]
  def exec_and(addr : UInt16)
    tmp = accumulator & memread(addr)

    set_zero(tmp)
    set_negative(tmp)

    @accumulator = tmp
  end

  @[Cr6502::A::Realization(name: "ASL", for: {
    0x0A => { m: "accumulator", len: 1, cycles: 2, ex: 0 },})]
  def exec_asl
    set_carry_u8(accumulator)
    tmp = accumulator << 1
    
    set_zero(tmp)
    set_negative(tmp)

    @accumulator = tmp
  end

  @[Cr6502::A::Realization(name: "ASL", for: {
    0x06 => { m: "zeropage",  len: 2, cycles: 5, ex: 0 },
    0x16 => { m: "zeropagex", len: 2, cycles: 6, ex: 0 },
    0x0E => { m: "absolute",  len: 3, cycles: 6, ex: 0 },
    0x1E => { m: "absolutex", len: 3, cycles: 7, ex: 0 },})]
  def exec_asl(addr : UInt16)
    mem = memread(addr)
    set_carry_u8(mem)

    tmp = mem << 1
    
    set_zero(tmp)
    set_negative(tmp)

    memwrite(addr, tmp)
  end

  @[Cr6502::A::Realization(name: "BCC", for: {
    0x90 => { m: "relative", len: 2, cycles: 2, ex: 2, br: true },})]
  def exec_bcc(mem : UInt16)
    if carry_flag?
      @pc += 2
    else
      @pc = mem
    end
  end

  @[Cr6502::A::Realization(name: "BCS", for: {
    0xB0 => { m: "relative", len: 2, cycles: 2, ex: 2, br: true },})]
  def exec_bcs(mem : UInt16)
    if carry_flag?
      @pc = mem
    else
      @pc += 2
    end
  end

  @[Cr6502::A::Realization(name: "BEQ", for: {
    0xF0 => { m: "relative", len: 2, cycles: 2, ex: 2, br: true },})]
  def exec_beq(mem : UInt16)
    if zero_flag?
      @pc = mem
    else
      @pc += 2
    end
  end

  @[Cr6502::A::Realization(name: "BIT", for: {
    0x24 => { m: "zeropage", len: 2, cycles: 3, ex: 0 },
    0x2C => { m: "absolute", len: 3, cycles: 4, ex: 0 },})]
  def exec_bit(addr : UInt16)
    mem = memread(addr)

    set_zero(mem & accumulator)
    set_negative(mem)

    ((mem >> 6) & 1) == 1 ? @flags.set(:overflow) : @flags.clear(:overflow)
  end

  @[Cr6502::A::Realization(name: "BMI", for: {
    0x30 => { m: "relative", len: 2, cycles: 2, ex: 2, br: true },})]
  def exec_bmi(mem : UInt16)
    if negative_flag?
      @pc = mem
    else
      @pc += 2
    end
  end

  @[Cr6502::A::Realization(name: "BNE", for: {
    0xD0 => { m: "relative", len: 2, cycles: 2, ex: 2, br: true },})]
  def exec_bne(mem)
    if zero_flag?
      @pc += 2
    else
      @pc = mem
    end
  end

  @[Cr6502::A::Realization(name: "BPL", for: {
    0x10 => { m: "relative", len: 2, cycles: 2, ex: 2, br: true },})]
  def exec_bpl(mem)
    if negative_flag?
      @pc += 2
    else
      @pc = mem
    end
  end

  @[Cr6502::A::Realization(name: "BRK", for: {
    0x00 => { m: "implied", len: 1, cycles: 7, ex: 0 },})]
  def exec_brk
    @flags.set(:brk)

    push_pc
    push_flags

    @pc = (memread(0xFFFF).to_u16 << 8) | memread(0xFFFE)
  end

  @[Cr6502::A::Realization(name: "BVC", for: {
    0x50 => { m: "relative", len: 2, cycles: 2, ex: 2, br: true },})]
  def exec_bvc(mem)
    if overflow_flag?
      @pc += 2
    else
      @pc = mem
    end
  end

  @[Cr6502::A::Realization(name: "BVS", for: {
    0x70 => { m: "relative", len: 2, cycles: 2, ex: 2 , br: true },})]
  def exec_bvs(mem)
    if overflow_flag?
      @pc = mem
    else
      @pc += 2
    end
  end

  @[Cr6502::A::Realization(name: "CLC", for: {
    0x18 => { m: "implied", len: 1, cycles: 2, ex: 0 },})]
  def exec_clc
    @flags.clear(:carry)
  end

  @[Cr6502::A::Realization(name: "CLD", for: {
    0xD8 => { m: "implied", len: 1, cycles: 2, ex: 0 },})]
  def exec_cld
    @flags.clear(:decimal)
  end

  @[Cr6502::A::Realization(name: "CLI", for: {
    0x58 => { m: "implied", len: 1, cycles: 2, ex: 0 },})]
  def exec_cli
    @flags.clear(:interrupt)
  end

  @[Cr6502::A::Realization(name: "CLV", for: {
    0xB8 => { m: "implied", len: 1, cycles: 2, ex: 0 },})]
  def exec_clv
    @flags.clear(:overflow)
  end

  @[Cr6502::A::Realization(name: "CMP", for: {
    0xC9 => { m: "immidiate", len: 2, cycles: 2, ex: 0 },
    0xC5 => { m: "zeropage",  len: 2, cycles: 3, ex: 0 },
    0xD5 => { m: "zeropagex", len: 2, cycles: 4, ex: 0 },
    0xCD => { m: "absolute",  len: 3, cycles: 4, ex: 0 },
    0xDD => { m: "absolutex", len: 3, cycles: 4, ex: 1 },
    0xD9 => { m: "absolutey", len: 3, cycles: 4, ex: 1 },
    0xC1 => { m: "indirectx", len: 2, cycles: 6, ex: 0 },
    0xD1 => { m: "indirecty", len: 2, cycles: 5, ex: 1 },})]
  def exec_cmp(addr : UInt16)
    mem = memread(addr)

    @flags.set(:carry) if accumulator >= mem
    @flags.set(:zero) if @accumulator == mem
    @flags.set(:negative) if accumulator > mem
  end

  @[Cr6502::A::Realization(name: "CPX", for: {
    0xE0 => { m: "immidiate", len: 2, cycles: 2, ex: 0 },
    0xE4 => { m: "zeropage",  len: 2, cycles: 3, ex: 0 },
    0xEC => { m: "absolute",  len: 3, cycles: 4, ex: 0 },})]
  def exec_cpx(addr : UInt16)
    mem = memread(addr)
    reg = registers[:x]

    @flags.set(:carry) if reg >= mem
    @flags.set(:zero) if reg == mem
    @flags.set(:negative) if reg > mem
  end

  @[Cr6502::A::Realization(name: "CPY", for: {
    0xC0 => { m: "immidiate", len: 2, cycles: 2, ex: 0 },
    0xC4 => { m: "zeropage",  len: 2, cycles: 3, ex: 0 },
    0xCC => { m: "absolute",  len: 3, cycles: 4, ex: 0 },})]
  def exec_cpy(addr : UInt16)
    mem = memread(addr)
    reg = registers[:y]

    @flags.set(:carry) if reg >= mem
    @flags.set(:zero) if reg == mem
    @flags.set(:negative) if reg > mem    
  end

  @[Cr6502::A::Realization(name: "DEC", for: {
    0xC6 => { m: "zeropage",  len: 2, cycles: 5, ex: 0 },
    0xD6 => { m: "zeropagex", len: 2, cycles: 6, ex: 0 },
    0xCE => { m: "absolute",  len: 3, cycles: 6, ex: 0 },
    0xDE => { m: "absolutex", len: 3, cycles: 7, ex: 0 },})]
  def exec_dec(addr : UInt16)
    mem = memread(addr)
    
    tmp = mem - 1

    set_zero(tmp)
    set_negative(tmp)

    memwrite(addr, tmp)
  end

  @[Cr6502::A::Realization(name: "DEX", for: {
    0xCA => { m: "implied", len: 1, cycles: 2, ex: 0 },})]
  def exec_dex
    tmp = registers[:x] - 1

    set_zero(tmp)
    set_negative(tmp)

    registers[:x] = tmp
  end

  @[Cr6502::A::Realization(name: "DEY", for: {
    0x88 => { m: "implied", len: 1, cycles: 2, ex: 0 },})]
  def exec_dey
    tmp = registers[:y] - 1

    set_zero(tmp)
    set_negative(tmp)

    registers[:y] = tmp
  end

  @[Cr6502::A::Realization(name: "EOR", for: {
    0x49 => { m: "immidiate", len: 2, cycles: 2, ex: 0 },
    0x45 => { m: "zeropage",  len: 2, cycles: 3, ex: 0 },
    0x55 => { m: "zeropagex", len: 2, cycles: 4, ex: 0 },
    0x4D => { m: "absolute",  len: 3, cycles: 4, ex: 0 },
    0x5D => { m: "absolutex", len: 3, cycles: 4, ex: 1 },
    0x59 => { m: "absolutey", len: 3, cycles: 4, ex: 1 },
    0x41 => { m: "indirectx", len: 2, cycles: 6, ex: 0 },
    0x51 => { m: "indirecty", len: 2, cycles: 5, ex: 1 },})]
  def exec_eor(addr : UInt16)
    mem = memread(addr)

    tmp = accumulator ^ mem

    set_zero(tmp)
    set_negative(tmp)

    @accumulator = tmp
  end

  @[Cr6502::A::Realization(name: "INC", for: {
    0xE6 => { m: "zeropage",  len: 2, cycles: 5, ex: 0 },
    0xF6 => { m: "zeropagex", len: 2, cycles: 6, ex: 0 },
    0xEE => { m: "absolute",  len: 3, cycles: 6, ex: 0 },
    0xFE => { m: "absolutex", len: 3, cycles: 7, ex: 0 },})]
  def exec_inc(addr : UInt16)
    mem = memread(addr)
    
    tmp = mem + 1

    set_zero(tmp)
    set_negative(tmp)

    memwrite(addr, tmp)
  end

  @[Cr6502::A::Realization(name: "INX", for: {
    0xE8 => { m: "implied", len: 1, cycles: 2, ex: 0 },})]
  def exec_inx
    tmp = registers[:x] + 1

    set_zero(tmp)
    set_negative(tmp)

    registers[:x] = tmp
  end

  @[Cr6502::A::Realization(name: "INY", for: {
    0xC8 => { m: "implied", len: 1, cycles: 2, ex: 0 },})]
  def exec_iny
    tmp = registers[:y] + 1

    set_zero(tmp)
    set_negative(tmp)

    registers[:y] = tmp
  end

  @[Cr6502::A::Realization(name: "JMP", for: {
    0x4C => { m: "absolute", len: 3, cycles: 3, ex: 0, br: true },
    0x6C => { m: "indirect", len: 3, cycles: 5, ex: 0, br: true },})]
  def exec_jmp(addr : UInt16)
    @pc = addr
  end

  @[Cr6502::A::Realization(name: "JSR", for: {
    0x20 => { m: "absolute", len: 3, cycles: 6, ex: 0, br: true},})]
  def exec_jsr(addr : UInt16)
    push_pc
    @pc = addr
  end

  @[Cr6502::A::Realization(name: "LDA", for: {
    0xA9 => { m: "immidiate", len: 2, cycles: 2, ex: 0 },
    0xA5 => { m: "zeropage",  len: 2, cycles: 3, ex: 0 },
    0xB5 => { m: "zeropagex", len: 2, cycles: 4, ex: 0 },
    0xAD => { m: "absolute",  len: 3, cycles: 4, ex: 0 },
    0xBD => { m: "absolutex", len: 3, cycles: 4, ex: 1 },
    0xB9 => { m: "absolutey", len: 3, cycles: 4, ex: 1 },
    0xA1 => { m: "indirectx", len: 2, cycles: 6, ex: 0 },
    0xB1 => { m: "indirecty", len: 2, cycles: 5, ex: 1 },})]
  def exec_lda(addr : UInt16)
    tmp = memread addr

    puts "LDA: mem: #{tmp.to_s(16)}"

    set_zero(tmp)
    set_negative(tmp)
    
    @accumulator = tmp
  end

  @[Cr6502::A::Realization(name: "LDX", for: {
    0xA2 => { m: "immidiate", len: 2, cycles: 2, ex: 0 },
    0xA6 => { m: "zeropage",  len: 2, cycles: 3, ex: 0 },
    0xB6 => { m: "zeropagey", len: 2, cycles: 4, ex: 0 },
    0xAE => { m: "absolute",  len: 3, cycles: 4, ex: 0 },
    0xBE => { m: "absolutey", len: 3, cycles: 4, ex: 1 },})]
  def exec_ldx(addr : UInt16)    
    tmp = memread addr

    set_zero(tmp)
    set_negative(tmp)
    
    registers[:x] = tmp
  end

  @[Cr6502::A::Realization(name: "LDY", for: {
    0xA0 => { m: "immidiate", len: 2, cycles: 2, ex: 0 },
    0xA4 => { m: "zeropage",  len: 2, cycles: 3, ex: 0 },
    0xB4 => { m: "zeropagex", len: 2, cycles: 4, ex: 0 },
    0xAC => { m: "absolute",  len: 3, cycles: 4, ex: 0 },
    0xBC => { m: "absolutex", len: 3, cycles: 4, ex: 1 },})]
  def exec_ldy(addr : UInt16)
    mem = memread(addr)
    
    set_zero(mem)
    set_negative(mem)
    
    registers[:y] = mem
  end

  @[Cr6502::A::Realization(name: "LSR", for: {
    0x4A => { m: "accumulator", len: 1, cycles: 2, ex: 0 },})]
  def exec_lsr
    tmp = accumulator >> 1

    set_zero(tmp)
    (accumulator & 1) == 1 ? @flags.set(:carry) : @flags.clear(:carry)

    @accumulator = tmp
  end

  @[Cr6502::A::Realization(name: "LSR", for: {
    0x46 => { m: "zeropage",  len: 2, cycles: 5, ex: 0 },
    0x56 => { m: "zeropagex", len: 2, cycles: 6, ex: 0 },
    0x4E => { m: "absolute",  len: 3, cycles: 6, ex: 0 },
    0x5E => { m: "absolutex", len: 3, cycles: 7, ex: 0 },})]
  def exec_lsr(addr : UInt16)
    mem = memread(addr)
    (mem & 1) == 1 ? @flags.set(:carry) : @flags.clear(:carry)
    tmp = mem >> 1

    set_zero(tmp)

    memwrite(addr, tmp)
  end

  @[Cr6502::A::Realization(name: "NOP", for: {
    0xEA => { m: "implied", len: 1, cycles: 2, ex: 0 },})]
  def exec_nop
    # NOPE!
  end

  @[Cr6502::A::Realization(name: "ORA", for: {
    0x09 => { m: "immidiate", len: 2, cycles: 2, ex: 0 },
    0x05 => { m: "zeropage",  len: 2, cycles: 3, ex: 0 },
    0x15 => { m: "zeropagex", len: 2, cycles: 4, ex: 0 },
    0x0D => { m: "absolute",  len: 3, cycles: 4, ex: 0 },
    0x1D => { m: "absolutex", len: 3, cycles: 4, ex: 1 },
    0x19 => { m: "absolutey", len: 3, cycles: 4, ex: 1 },
    0x01 => { m: "indirectx", len: 2, cycles: 6, ex: 0 },
    0x11 => { m: "indirecty", len: 2, cycles: 5, ex: 1 },})]
  def exec_ora(addr : UInt16)
    mem = memread(addr)
    tmp = accumulator | mem

    set_zero(tmp)
    set_negative(tmp)

    @accumulator = tmp
  end

  @[Cr6502::A::Realization(name: "PHA", for: {
    0x48 => { m: "implied", len: 1, cycles: 3, ex: 0 },})]
  def exec_pha
    stack_push accumulator
  end

  @[Cr6502::A::Realization(name: "PHP", for: {
    0x08 => { m: "implied", len: 1, cycles: 3, ex: 0 },})]
  def exec_php
    push_flags
  end

  @[Cr6502::A::Realization(name: "PLA", for: {
    0x68 => { m: "implied", len: 1, cycles: 4, ex: 0 },})]
  def exec_pla
    tmp = stack_pop

    set_zero(tmp)
    set_negative(tmp)

    @accumulator = tmp
  end

  @[Cr6502::A::Realization(name: "PLP", for: {
    0x28 => { m: "implied", len: 1, cycles: 4, ex: 0 },})]
  def exec_plp
    @flags = Flags.new(stack_pop)
  end

  @[Cr6502::A::Realization(name: "ROL", for: {
    0x2A => { m: "accumulator", len: 1, cycles: 2, ex: 0 },})]
  def exec_rol
    old_carry = carry_flag? ? 1 : 0
    new_carry = (accumulator >> 7) & 1

    tmp = (accumulator << 1) | old_carry

    new_carry == 1 ? @flags.set(:carry) : @flags.clear(:carry)
    set_zero(tmp)
    set_negative(tmp)

    @accumulator = tmp
  end

  @[Cr6502::A::Realization(name: "ROL", for: {
    0x26 => { m: "zeropage",  len: 2, cycles: 5, ex: 0 },
    0x36 => { m: "zeropagex", len: 2, cycles: 6, ex: 0 },
    0x2E => { m: "absolute",  len: 3, cycles: 6, ex: 0 },
    0x3E => { m: "absolutex", len: 3, cycles: 7, ex: 0 },})]
  def exec_rol(addr : UInt16)
    mem = memread(addr)
    new_carry = (mem >> 7) & 1
    old_carry = carry_flag? ? 1 : 0

    tmp = (mem << 1) | old_carry

    new_carry == 1 ? @flags.set(:carry) : @flags.clear(:carry)
    set_zero(tmp)
    set_negative(tmp)

    memwrite(addr, tmp)
  end

  @[Cr6502::A::Realization(name: "ROR", for: {
    0x6A => { m: "accumulator", len: 1, cycles: 2, ex: 0 },})]
  def exec_ror
    old_carry = carry_flag? ? 1 : 0
    new_carry = accumulator & 1

    tmp = (accumulator >> 1) | (old_carry << 7)

    new_carry == 1 ? @flags.set(:carry) : @flags.clear(:carry)
    set_zero(tmp)
    set_negative(tmp)

    @accumulator = tmp
  end

  @[Cr6502::A::Realization(name: "ROR", for: {
    0x66 => { m: "zeropage",  len: 2, cycles: 5, ex: 0 },
    0x76 => { m: "zeropagex", len: 2, cycles: 6, ex: 0 },
    0x6E => { m: "absolute",  len: 3, cycles: 6, ex: 0 },
    0x7E => { m: "absolutex", len: 3, cycles: 7, ex: 0 },})]
  def exec_ror(addr : UInt16)
    mem = memread(addr)

    old_carry = carry_flag? ? 1 : 0
    new_carry = mem & 1
    
    tmp = (mem >> 1) | (old_carry << 7)

    new_carry == 1 ? @flags.set(:carry) : @flags.clear(:carry)
    set_zero(tmp)
    set_negative(tmp)

    memwrite(addr, tmp)
  end

  @[Cr6502::A::Realization(name: "RTI", for: {
    0x40 => { m: "implied", len: 1, cycles: 6, ex: 0, br: true },})]
  def exec_rti
    @flags = Flags.new(stack_pop)
    @pc = pop_pc
  end

  @[Cr6502::A::Realization(name: "RTS", for: {
    0x60 => { m: "implied", len: 1, cycles: 6, ex: 0, br: true },})]
  def exec_rts
    # stack_inspect

    @pc = pop_pc + 1
  end

  @[Cr6502::A::Realization(name: "SBC", for: {
    0xE9 => { m: "immidiate", len: 2, cycles: 2, ex: 0 },
    0xE5 => { m: "zeropage",  len: 2, cycles: 3, ex: 0 },
    0xF5 => { m: "zeropagex", len: 2, cycles: 4, ex: 0 },
    0xED => { m: "absolute",  len: 3, cycles: 4, ex: 0 },
    0xFD => { m: "absolutex", len: 3, cycles: 4, ex: 1 },
    0xF9 => { m: "absolutey", len: 3, cycles: 4, ex: 1 },
    0xE1 => { m: "indirectx", len: 2, cycles: 6, ex: 0 },
    0xF1 => { m: "indirecty", len: 2, cycles: 5, ex: 1 },})]
  def exec_sbc(addr : UInt16)
    old_accumulator = accumulator
    mem = memread(addr)
    tmp = accumulator.to_u16 &- mem.to_u16 &- carry_flag.to_u16
       
    set_carry_u16(tmp)
    set_adc_overflow(old_accumulator, accumulator, mem)

    @accumulator = (tmp && 0xFF).to_u8
    set_zero(accumulator)
    set_negative(accumulator)
  end

  @[Cr6502::A::Realization(name: "SEC", for: {
    0x38 => { m: "implied", len: 1, cycles: 2, ex: 0 },})]
  def exec_sec
    @flags.set(:carry)
  end

  @[Cr6502::A::Realization(name: "SED", for: {
    0xF8 => { m: "implied", len: 1, cycles: 2, ex: 0 },})]
  def exec_sed
    @flags.set(:decimal)
  end

  @[Cr6502::A::Realization(name: "SEI", for: {
    0x78 => { m: "implied", len: 1, cycles: 2, ex: 0 },})]
  def exec_sed
    @flags.set(:interrupt)
  end

  @[Cr6502::A::Realization(name: "STA", for: {
    0x85 => { m: "zeropage",  len: 2, cycles: 3, ex: 0 },
    0x95 => { m: "zeropagex", len: 2, cycles: 4, ex: 0 },
    0x8D => { m: "absolute",  len: 3, cycles: 4, ex: 0 },
    0x9D => { m: "absolutex", len: 3, cycles: 5, ex: 0 },
    0x99 => { m: "absolutey", len: 3, cycles: 5, ex: 0 },
    0x81 => { m: "indirectx", len: 2, cycles: 6, ex: 0 },
    0x91 => { m: "indirecty", len: 2, cycles: 6, ex: 0 },})]
  def exec_sta(addr : UInt16)
    memwrite(addr, accumulator)
  end

  @[Cr6502::A::Realization(name: "STX", for: {
    0x86 => { m: "zeropage",  len: 2, cycles: 3, ex: 0 },
    0x96 => { m: "zeropagey", len: 2, cycles: 4, ex: 0 },
    0x8E => { m: "absolute",  len: 3, cycles: 4, ex: 0 },})]
  def exec_stx(addr : UInt16)
    memwrite(addr, registers[:x])
  end

  @[Cr6502::A::Realization(name: "STY", for: {
    0x84 => { m: "zeropage",  len: 2, cycles: 3, ex: 0 },
    0x94 => { m: "zeropagex", len: 2, cycles: 4, ex: 0 },
    0x8C => { m: "absolute",  len: 3, cycles: 4, ex: 0 },})]
  def exec_sty(addr : UInt16)
    memwrite(addr, registers[:y])
  end

  @[Cr6502::A::Realization(name: "TAX", for: {
    0xAA => { m: "implied", len: 1, cycles: 2, ex: 0 },})]
  def exec_tax
    registers[:x] = accumulator

    set_zero(registers[:x])
    set_negative(registers[:x])
  end

  @[Cr6502::A::Realization(name: "TAY", for: {
    0xA8 => { m: "implied", len: 1, cycles: 2, ex: 0 },})]
  def exec_tay
    registers[:y] = accumulator

    set_zero(registers[:y])
    set_negative(registers[:y])
  end

  @[Cr6502::A::Realization(name: "TSX", for: {
    0xBA => { m: "implied", len: 1, cycles: 2, ex: 0 },})]
  def exec_tsx
    registers[:x] = (@pc && 0xFFFF).to_u8

    set_zero(registers[:x])
    set_negative(registers[:x])
  end

  @[Cr6502::A::Realization(name: "TXA", for: {
    0x8A => { m: "implied", len: 1, cycles: 2, ex: 0 },})]
  def exec_txa
    @accumulator = registers[:x]

    set_zero(accumulator)
    set_negative(accumulator)
  end

  @[Cr6502::A::Realization(name: "TXS", for: {
    0x9A => { m: "implied", len: 1, cycles: 2, ex: 0, br: true },})]
  def exec_txs
    @pc = registers[:x].to_u16
  end

  @[Cr6502::A::Realization(name: "TYA", for: {
    0x98 => { m: "implied", len: 1, cycles: 2, ex: 0 },})]
  def exec_tya
    @accumulator = registers[:y]
    
    set_zero(accumulator)
    set_negative(accumulator)
  end
end
