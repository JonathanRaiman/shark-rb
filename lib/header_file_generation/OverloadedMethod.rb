module HeaderFileGenerator
	class HeaderFile
		class OverloadedMethod < HeaderFileGenerator::HeaderFile::Method
			attr_reader :parameter_families
			attr_reader :number_of_inputs_per_family
			attr_accessor :observed_family

			def initialize opts={}
				raise StandardError.new "\"name\" cannot contain any non a-Z 0-9 _ characters" if (opts["name"] and opts["name"].match(/[^a-zA-Z0-9_]/))
				@header_file      = opts["hf"]
				if opts["hf"].nil? then raise StandardError.new "Cannot initialize a header file method without providing a Header File." end
				@method_name      = opts["name"]

				@number_of_inputs_per_family = opts["overload"].map {|i| i["types"].nil? ? 0 : i["types"].length}
				@return_type_per_family      = opts["overload"].map {|i| create_return_type i["type"]}
				@parameter_families          = []
				@parameters                  = []
				@cpp_method_name             = opts["overload"].map {|i| (i["accessor_name"] || opts["accessor_name"]) || opts["name"]}
				@min_number_of_inputs        = @number_of_inputs_per_family.min
				@max_number_of_inputs        = @number_of_inputs_per_family.max
				opts["overload"].each_with_index do |overload, k|
					parameter_family = []
					@number_of_inputs_per_family[k].times do |i|
						input_type = opts["overload"][k]["types"][i] || opts["overload"][k]["types"][0]
						if input_type.is_a? Array
							parameter_family << OverloadedInput.new(
								:type         => input_type,
								:position     => i,
								:method       => self,
								:output_classes => input_type.map {|intype| CppClass.guess_from_type(intype)}
								)
						else
							parameter_family << Input.new(
								:type         => input_type,
								:position     => i,
								:method       => self,
								:output_class => CppClass.guess_from_type(input_type)
								)
						end
					end
					@parameter_families << parameter_family
				end
				@requires_conversion_per_family = @parameter_families.map {|i| i.any? {|param| param.requires_conversion?}}
				@observed_family = nil
			end

			def matches_family family
				family_tests = Conjunction.new(family.map {|i| i.is_a?(OverloadedInput) ? Disjunction.new(i.type.map {|t| i.check_for_type(t)}) : i.check_for_type(i.type)}).negate
				if variable_number_of_arguments?
					Conjunction.new(
						[
							"number_of_arguments == #{family.length}",
							family_tests
						]
					)
				else
					family_tests
				end
			end

			def overloaded_call_methodology
				# here we test to see in which family we are...
				cpp = ""
				indent = 1
				parameter_families.each_with_index do |family, k|
					@observed_family = k
					cpp += (k==0 ? "#{"\t"*indent}if" : " else if") + " " + (matches_family family ).to_s + " " + "{\n"

					cpp += "#{checking_methodology(family, indent + 1)}"
					if @requires_conversion_per_family[k]
						cpp += "#{call_methodology_with_conversion family, indent + 1}\n#{"\t"*indent}}"
					else
						cpp += "#{return_methodology(family, indent + 1)}\n#{"\t"*indent}}"
					end
					@observed_family = nil
				end
				cpp += "\n"
				# add safety return self here...
			end

			def to_cpp_function_definition
"""
VALUE #{function_name} (#{input_parameters}) {
#{extra_input_parameters_declarations}
	#{cpp_class.pointer} #{symbol};
	Data_Get_Struct(self, #{cpp_class}, #{symbol});
#{overloaded_call_methodology}
}
"""
			end

			def current_return_type
				if @observed_family.nil? then raise RuntimeError.new "Asking for return type in overloaded method when no family is specified." end
				@return_type_per_family[@observed_family][0]
			end

			def current_cast_return_type_cast
				if @observed_family.nil? then raise RuntimeError.new "Asking for return type in overloaded method when no family is specified." end
				@return_type_per_family[@observed_family][1]
			end

			def current_cpp_method_name
				if @observed_family.nil? then raise RuntimeError.new "Asking for cpp method name in overloaded method when no family is specified." end
				@cpp_method_name[@observed_family]
			end

			def variable_number_of_arguments?
				@max_number_of_inputs > 0 and @max_number_of_inputs != @min_number_of_inputs
			end

			def extra_input_parameters_declarations
				if variable_number_of_arguments?
					ip = "\tVALUE "
					param_names = []
					@max_number_of_inputs.times do |i|
						param_names << parameter_name(i)
					end
					ip += param_names.join(", ") + ";\n"
					ip += "\trb_scan_args(number_of_arguments, ruby_arguments, \"#{@min_number_of_inputs}#{@max_number_of_inputs-@min_number_of_inputs}\", "
					ip += ("&" + param_names.join(", &") + ");\n")
					ip
				else
					""
				end
			end

			def to_rb_function_definition
				"rb_define_method(#{cpp_class.rb_class}, \"#{rb_method_name}\", (rb_method) #{function_name}, #{variable_number_of_arguments? ? -1 : @max_number_of_inputs});"
			end

			def input_parameters
				if @max_number_of_inputs == @min_number_of_inputs
					ip =  "VALUE self"
					@max_number_of_inputs.times do |i|
						ip += ", VALUE #{parameter_name(i)}"
					end
					ip
				else
					"int number_of_arguments, VALUE* ruby_arguments, VALUE self"
				end
			end
		end
	end
end