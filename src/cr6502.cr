require "./cpu.cr"

# TODO: Write documentation for `Cr6502`
module Cr6502
  VERSION = "0.1.0"

  # TODO: Put your code here
end

rom = "cpu_dummy_reads.nes"

file = File.open(rom)
memory = Array(UInt8).new(0xFFFF, 0)
starts = [0x0000_u16]

(0...file.size).each do |i|
  value = file.read_bytes(UInt8, IO::ByteFormat::BigEndian)
  starts.each do |s|
    memory[i + s] = value
  end
end

# ram.Write(0x8000, romData);
# ram.Write(0xC000, romData);

cpu = Cr6502::CPU.new(memory, start: 0x6000)

while cpu.running?
  cpu.cycle!
end

# Cr6502::CPU.puk
# Cr6502::CPU.new.exec(0x69)

 