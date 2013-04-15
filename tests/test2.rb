require "ruby-libsamplerate"

fil = IO.read("/Users/herooftime/Desktop/ferg-mono.pcm")
ar = fil.unpack("s*")
puts ar.size

# zeroes = 0
# ar.each { |sample| zeroes+=1 if sample == 0.0 }
# puts "zeroes: #{zeroes}"

far = SRC::Convert.short_to_float ar
puts far.size

r = SRC::Simple.new 44100, 48000, 1
rs = r.resample far
puts rs.size

srs = SRC::Convert.float_to_short rs

# puts rs.length
# zeroes = 0
# rs.each { |sample| zeroes+=1 if sample == 0.0 }
# puts "zeroes: #{zeroes}"

out = File.open("/Users/herooftime/Desktop/re-out-raw.pcm", "w+")

  mono_data = Array.new
  srs.each_index do |i|
    if i % 2 == 0
      left = srs[i]
      right = srs[i+1]
      # mono_data << (right/2 - left/2) if left && right
      mono_data << left
    end
  end

out.syswrite mono_data.pack("s*")
out.close