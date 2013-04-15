module SRC
	class Data < FFI::Struct
		layout	:data_in, :pointer,
				:data_out, :pointer,
				:input_frames, :long,
				:output_frames, :long,
				:input_frames_used, :long,
				:output_frames_gen, :long,
				:end_of_input, :int,
				:src_ratio, :double
	end
end