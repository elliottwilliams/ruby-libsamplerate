require "ruby-libsamplerate"

fil = File.open("/Users/herooftime/Desktop/ferg.pcm")
out = File.open("/Users/herooftime/Desktop/re-out-raw.pcm", "w+")
r = SRC::Resample.new 44100, 48000, 2

size_of_10ms = (44100 / 100) * 2

while (buffer = fil.read(size_of_10ms)) do
	data = buffer.unpack("s*")
	data_f = SRC::Convert.short_to_float data

	rs = r.process data_f
	srs = SRC::Convert.float_to_short rs

	out.syswrite srs.pack("s*")
end

fil.close
out.close