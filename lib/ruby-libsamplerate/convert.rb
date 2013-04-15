module SRC
	class Convert
		def self.short_to_float(data)
			base_convert data, :short, :float
		end

		def self.float_to_short(data)
			base_convert data, :float, :short
		end

		def self.int_to_float(data)
			base_convert data, :int16, :float
		end

		def self.float_to_int(data)
			base_convert data, :float, :int16
		end

		private

		def self.base_convert(data, in_type, out_type)
			size = data.size
			input = FFI::MemoryPointer.new in_type, size

			write_ar = input.method "write_array_of_#{in_type}".to_sym
			write_ar.call data

			output = FFI::MemoryPointer.new out_type, size
			converter = SRC.method "src_#{in_type}_to_#{out_type}_array"
			converter.call input, output, size

			read_ar = output.method "read_array_of_#{out_type}".to_sym
			read_ar.call size
		end
	end
end