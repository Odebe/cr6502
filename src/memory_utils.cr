module Cr6502::MemoryUtils
  def memread(addr : UInt16)
    @memory[addr]
  end

  def stack_inspect
    (0...256).each do |sp|
      puts "[#{(0x0100u16 + sp).to_s(16)}] = [#{(@memory[0x0100u16 + sp]).to_s(16)}]"
    end
  end

  def memwrite(addr : UInt16, value : UInt8) : Nil
    # puts "writing '#{value.to_s(16)}' at '#{addr.to_s(16)}'"
    @memory[addr] = value
  end

  def push_flags : Nil
    stack_push @flags.value
  end

  def push_pc : Nil
    stack_push ((@pc & 0xFF00) >> 8).to_u8
    stack_push (@pc & 0xFF).to_u8
  end

  def stack_peek
    memread(0x0100u16 + @sp + 1)
  end

  def pop_pc : UInt16
    high = stack_pop
    low = stack_pop

    (low.to_u16 << 8) | high
  end

  def stack_pop : UInt8
    @sp += 1
    value = memread(0x0100u16 + @sp)
    puts "poping '#{value.to_s(16)}' from stack at '#{(0x0100_u16 + @sp).to_s(16)}'"
    value
  end

  def stack_push(value : UInt8) : Nil
    puts "pushing '#{value.to_s(16)}' to stack at '#{(0x0100_u16 + @sp).to_s(16)}'"
    memwrite(0x0100_u16 + @sp, value)
    @sp -= 1
  end

  def read_addr_for(mode) : UInt16
    case mode 
    when "immidiate"
      @pc + 1
    when "relative"
      rel_addr(@pc)
    when "zeropage" 
      @memory[@pc + 1]
    when "zeropagex" 
      (@memory[@pc + 1] + @registers[:x] % 256)
    when "zeropagey" 
      (@memory[@pc + 1] + @registers[:y] % 256)
    when "absolute" 
      abs_addr(@pc)
    when "absolutex"
      abs_addr(@pc) + @registers[:x]
    when "absolutey" 
      abs_addr(@pc) + @registers[:y]
    when "indirectx" 
      ind_addr(@pc) + @registers[:x]
    when "indirecty" 
      ind_addr(@pc) + @registers[:y]
    else
      raise "Undefined mode: #{mode}"
    end.to_u16
  end

  private macro rel_addr(pc)
    {{ pc }} + 2 + @memory[{{ pc }} + 1].to_u16
  end

  private macro abs_addr(pc)
    (@memory[{{ pc }} + 2].to_u16 << 8) | @memory[{{ pc }} + 1].to_u16
  end

  private macro ind_addr(pc)
    %low = @memory[{{ pc }} + 1].to_u16
    %high = (%low + 1) % 256
    @memory[%low].to_u16 + (@memory[%high].to_u16 << 8)
  end
end
