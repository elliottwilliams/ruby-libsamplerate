require "resample"
r = Resample::Simple.new 44100, 48000, 1

# def read_file(size)
#   File.open("/Users/herooftime/Desktop/gang-44k-raw.pcm") do |file|
#     while (buffer = file.read(size)) do
#       yield buffer
#     end
#   end
# end

out   = File.open "/Users/herooftime/Desktop/gang-out.pcm", "w+"

out.syswrite r.resample IO.read("/Users/herooftime/Desktop/gang-44k-raw.pcm")

puts "Allah done."