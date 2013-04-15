module SRC
	class Resample
		attr_accessor :input_rate, :output_rate, :channels

		def initialize(input_rate, output_rate, channels=1, type=SRC_SINC_FASTEST)
			@input_rate = input_rate
			@output_rate = output_rate
			@channels = channels

			error = FFI::MemoryPointer.new :int, 1
			@state = SRC.src_new type, channels, error
		end

		def src_ratio
			@output_rate.to_f / @input_rate.to_f
		end

		def process(data)
			size = data.size
			frames = size / @channels
			rs_frames = (frames * src_ratio).to_i
			rs_size = rs_frames * @channels

			input = FFI::MemoryPointer.new :float, size
			output = FFI::MemoryPointer.new :float, rs_size
			input.write_array_of_float data

			src_data = Data.new
			src_data[:data_in] = input
			src_data[:input_frames] = frames
			src_data[:data_out] = output
			src_data[:output_frames] = rs_frames
			src_data[:src_ratio] = src_ratio
			src_data[:end_of_input] = 0

			res = SRC.src_process @state, src_data

			raise SRCError.from_int res unless res == 0

			frames_written = src_data[:output_frames_gen]
			src_data[:data_out].read_array_of_float frames_written * @channels
		end

		def reset
			SRC.src_reset @state
		end

		def destroy
			SRC.src_delete @state
		end

	end
end