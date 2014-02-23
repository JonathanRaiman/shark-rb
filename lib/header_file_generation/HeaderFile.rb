module HeaderFileGenerator
	class HeaderFile
		attr_reader :getters
		attr_reader :setters
		attr_reader :cpp_class_name

		def define_getters getter_list=[]
			if !getter_list.nil?
				getter_list.each do |s|
					@getters << Getter.new(s.merge({"hf" => self}))
				end
			end
		end

		def define_setters setter_list=[]
			if !setter_list.nil?
				setter_list.each do |s|
					@setters << Setter.new(s.merge({"hf" => self}))
				end
			end
		end

		def define_methods method_list=[]
			if !method_list.nil?
				method_list.each do |s|
					@methods << Method.new(s.merge({"hf" => self}))
				end
			end
		end

		def initialize(opts={})
			@setters = []
			@getters = []
			@methods = []
			@wrapped_class = opts["wrapped_class"]
			@dependencies = opts["dependencies"]
			@cpp_class_name = opts["class"]
			@rb_class_name = opts["rb_class"]
			# this is to define the function that returns the class and singleton methods too
			@methods << Allocator.new("hf" => self)
			define_setters(opts["setters"])
			define_getters(opts["getters"])
			define_methods(opts["methods"])
		end

		def generate_init_function
			rb_function_definitions = []
			@setters.each do |setter|
				rb_function_definitions << ("\t"+setter.to_rb_function_definition)
			end
			@getters.each do |getter|
				rb_function_definitions << ("\t"+getter.to_rb_function_definition)
			end
			@methods.each do |method|
				rb_function_definitions << ("\t"+method.to_rb_function_definition)
			end
			func_definition = rb_function_definitions.join("\n")
"""
void Init_#{@cpp_class_name} () {
#{func_definition}
}"""
		end

		def include_header_file
			"#include \"#{@cpp_class_name}.h\""
		end

		def include_pointer_wrapper_extras
			"#include \"extras/utils/rb_pointer_wrapping.extras\""
		end

		def generate_rb_class_function
"""
extern VALUE #{@rb_class_name};

VALUE #{@cpp_class_name}::rb_class() {
	return #{@rb_class_name};
}
"""
		end

		def to_cpp_file
			cpp = ""
			cpp += include_header_file
			cpp += "\n"
			cpp += include_pointer_wrapper_extras
			cpp += "\n"
			cpp += generate_rb_class_function
			@setters.each do |setter|
				cpp += setter.to_function_definition
			end
			@getters.each do |getter|
				cpp += getter.to_function_definition
			end
			@methods.each do |method|
				cpp += method.to_function_definition
			end
			cpp += generate_init_function
			cpp
		end

		def h_file_dependencies
	@dependencies.map {|i| "#include "+i}.join("\n")
		end

		def to_h_file
			"""
#ifndef #{@cpp_class_name.upcase}_H
#define #{@cpp_class_name.upcase}_H

#{h_file_dependencies}

class #{@cpp_class_name} {

	public:
		VALUE rb_class();
		#{@wrapped_class}   model;
		#{@wrapped_class} * getModel();
		#{@cpp_class_name}();
};
#endif
"""
		end
	end
end