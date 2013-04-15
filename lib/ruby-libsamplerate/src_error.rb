module SRC

	class SRCError < StandardError
		def self.from_int(code)
			strerror = SRC.src_strerror code
			SRCError.new strerror.get_string 0
		end

		def self.from_pointer(ptr)
			self.from_int ptr.read_int
		end
	end
end