require "ffi"
require "ruby-libsamplerate/data"
require "ruby-libsamplerate/simple"
require "ruby-libsamplerate/resample"
require "ruby-libsamplerate/convert"
require "ruby-libsamplerate/src_error"
require "ruby-libsamplerate/version"

module SRC
	extend FFI::Library

	ffi_lib 'libsamplerate'

	SRC_SINC_BEST_QUALITY  	= 0
    SRC_SINC_MEDIUM_QUALITY	= 1
    SRC_SINC_FASTEST       	= 2
    SRC_ZERO_ORDER_HOLD    	= 3
    SRC_LINEAR             	= 4



	attach_function :src_simple,				[:pointer, :int, :int],		:int
	attach_function :src_new,					[:int, :int, :pointer],		:pointer
	attach_function :src_delete,				[:pointer],					:pointer
	attach_function :src_process,				[:pointer, :pointer],		:int
	attach_function :src_reset,					[:pointer],					:int
	attach_function :src_set_ratio,				[:pointer, :double],		:int
	attach_function :src_short_to_float_array,	[:pointer, :pointer, :int],	:void
	attach_function :src_float_to_short_array,	[:pointer, :pointer, :int],	:void
	attach_function :src_int_to_float_array,	[:pointer, :pointer, :int],	:void
	attach_function :src_float_to_int_array,	[:pointer, :pointer, :int],	:void
	attach_function :src_strerror,				[:int],						:pointer
end
