require "./cpu.cr"

# TODO: Write documentation for `Cr6502`
module Cr6502
  VERSION = "0.1.0"

  # TODO: Put your code here
end

rom = "nestest.nes"
# rom = "cpu_dummy_reads.nes"
start = 0xC000_u16

memory = Array(UInt8).new(0x10000, 0)

file = File.open(rom)
file.seek(0x0010, IO::Seek::Set)

(0x4000 - 1).times do |i|
  value = file.read_bytes(UInt8, IO::ByteFormat::LittleEndian)
  
  memory[i + 0x8000_u16] = value
  memory[i + 0xC000_u16] = value
end

cpu = Cr6502::CPU.new(memory, start: start)

while cpu.running?
  cpu.cycle!
end
