module Cr6502::CpuMemory
  macro read_arg_16
    begin
      hh = @memory[@pc + 1]
      ll = @memory[@pc + 2]
      (hh.to_u16  << 8) | ll 
    end 
  end

  macro read_arg_8
    @memory[@pc + 1]
  end

  def resolve_Addr
end