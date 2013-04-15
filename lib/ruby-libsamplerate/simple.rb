module SRC
	class Simple
		attr_accessor :input_rate, :output_rate, :channels

		def initialize(input_rate, output_rate, channels)
			@input_rate = input_rate
			@output_rate = output_rate
			@channels = channels
		end

		def src_ratio
			@output_rate.to_f / @input_rate.to_f
		end

		def resample(data)
			size = data.size
			frames = size / @channels
			rs_frames = (frames * src_ratio).to_i
			rs_size = rs_frames * @channels

			input = FFI::MemoryPointer.new :float, size
			output = FFI::MemoryPointer.new :float, rs_size
			input.write_array_of_float data

			src = Data.new
			src[:data_in] = input
			src[:input_frames] = frames
			src[:data_out] = output
			src[:output_frames] = rs_frames
			src[:src_ratio] = src_ratio


			res = SRC.src_simple src, SRC::SRC_SINC_FASTEST, @channels

			raise SRCError.from_int res unless res == 0


			frames_written = src[:output_frames_gen]
			src[:data_out].read_array_of_float frames_written * @channels
		end

	end
end