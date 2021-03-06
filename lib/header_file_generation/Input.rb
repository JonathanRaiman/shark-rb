module HeaderFileGenerator
	class HeaderFile
		class Method
			class Input
				attr_reader :type
				attr_reader :converted
				attr_accessor :input_class
				attr_accessor :output_class
				attr_reader :position

				ArrayTypes   = [:array, :"1darray", :vector, :"std::vector<double>"]
				MatrixTypes  = [:matrix, :"2darray"]
				IntegerTypes = [:integer, :int]

				def initialize(opts={})
					@type = opts[:type].to_sym
					@position = opts[:position]
					@converted = false
					@method = opts[:method]
					@output_class = opts[:output_class]
				end

				def parameter_name
					"parameter_#{@position+1}"
				end

				# could also test whether the detected class requires a pointer...
				def converted_parameter_name
					"parameter_#{@position+1}_converted"
				end

				def differs_from_classes classes
					Conjunction.new classes.map {|i| i.test_class parameter_name, false}
				end

				def compatible_classes
					classes = CppClass.can_convert_to(@output_class)
					if classes.empty? then raise CppError.new "No compatible C++ conversion classes for #{@output_class}."
					else classes end
				end

				def convert_and_embed(all_params, remaining_params, calling_methodology, indent=0)
					if requires_conversion?
						cpp = ""
						compatible_classes.each_with_index do |cpp_class, k|
							cpp += (k==0 ? "#{"\t"*indent}if" : " else if") + " " + (matches_classes [cpp_class] ).to_s + " " + "{\n"
							cpp += cpp_class.convert_into_class self, indent+1
							self.input_class = cpp_class
							if remaining_params.length > 0
								cpp += remaining_params.first.convert_and_embed all_params, remaining_params[1..(remaining_params.length-1)], calling_methodology, indent+1
							else
								cpp += (calling_methodology.call(indent+1) + "\n")
							end
							cpp += ("\t"*indent+"}")
						end
						cpp += "\n"
						cpp
					else
						if remaining_params.length > 0
							remaining_params.first.convert_and_embed all_params, remaining_params[1..(remaining_params.length-1)], calling_methodology, indent
						else
							calling_methodology.call(indent) + "\n"
						end
					end
				end

				def requires_conversion?
					!((IntegerTypes + [:double]).include? @type)
				end

				def matches_classes classes
					Disjunction.new classes.map {|i| i.test_class parameter_name}
				end

				def test_if_not_1darray
					Disjunction.new(
						[
							"TYPE(#{parameter_name}) != T_ARRAY",
							Conjunction.new(
								[
									"RARRAY_LEN(#{parameter_name}) > 0",
									"TYPE(rb_ary_entry(#{parameter_name}, 0)) != T_FLOAT",
									"TYPE(rb_ary_entry(#{parameter_name}, 0)) != T_FIXNUM"
								]
							)

						]
					)
				end

				def test_if_not_2darray
					Disjunction.new(
						[
							"TYPE(#{parameter_name}) != T_ARRAY",
							Conjunction.new(
								[
									"RARRAY_LEN(#{parameter_name}) > 0",
									"TYPE( rb_ary_entry(#{parameter_name}, 0) ) != T_ARRAY"
								]
							),
							Conjunction.new(
								[
									"RARRAY_LEN(#{parameter_name}) > 0",
									"RARRAY_LEN(rb_ary_entry(#{parameter_name}, 0)) > 0",
									"TYPE(rb_ary_entry(rb_ary_entry(#{parameter_name}, 0), 0)) != T_FLOAT",
									"TYPE(rb_ary_entry(rb_ary_entry(#{parameter_name}, 0), 0)) != T_FIXNUM"
								]
							)
						]
					)
				end

				def comment_about_check type, indent=0
					"#{"\t"*indent}// Checking whether #{parameter_name} is a#{type.to_s =~ /^[aeiou]/ ? "n" : ""} \"#{type}\"\n"
				end

				def check_for_type type
					case type
					when :double
						differs_from_classes(CppClass::RubyDoubleClasses + CppClass::RubyIntegerClasses).error_message("#{(@position+1).to_word} Argument must be a Float.")
					when *IntegerTypes
						differs_from_classes(CppClass::RubyDoubleClasses + CppClass::RubyIntegerClasses).error_message("#{(@position+1).to_word} Argument must be an Integer.")
					when *ArrayTypes
						Conjunction.new([test_if_not_1darray, differs_from_classes(CppClass::ArrayClasses)]).error_message("#{(@position+1).to_word} Argument must be an ArrayType (\\\"#{(CppClass::ArrayClasses.map {|i| i.wrapped_class} + ["Array"]).join("\\\", \\\"")}\\\")")
					when *MatrixTypes
						Conjunction.new([
		test_if_not_2darray,
		differs_from_classes(CppClass::MatrixClasses)
		]).error_message("#{(@position+1).to_word} Argument must be an MatrixType (\\\"#{(CppClass::MatrixClasses.map {|i| i.wrapped_class} + ["Array< Array< Float > >"]).join("\\\", \\\"")}\\\").")
					else# implement other checks as needs be.
						nil
					end
				end

				def check indent=1
					if test = check_for_type(@type)
						comment_about_check(@type, indent) + test.rb_raise_if(nil, indent)
					else
						""
					end
				end

				def has_input_class!
					if @input_class.nil? then raise RuntimeError.new "#{parameter_name} of type #{@type} was used in method \"#{@method.method_name}\" accessed via \"#{@method.cpp_method_name}\" before an input class was determined. (#{@method.header_file.inspect})" end
				end

				def to_converted_form_for_type type, outclass
					case type
					when :double
						Converter.convert(parameter_name).from(Float).to("double").to_s
					when *IntegerTypes
						Converter.convert(parameter_name).from(Fixnum).to("int").to_s
					when *(MatrixTypes+ArrayTypes + (MatrixTypes+ArrayTypes).map {|i| (i.to_s + "*").to_sym})
						Converter.convert(@input_class.converted_parameter_pointer(converted_parameter_name)).from(@input_class.wrapped_class).to(outclass).to_s
					else # must've been converted beforehand...
						#if requires_conversion? then raise RuntimeError.new "#{parameter_name} of type #{@type} was used in method \"#{@method.method_name}\" accessed via \"#{@method.cpp_method_name}\" with no conversion." end
						parameter_name
					end
				end

				def to_converted_form
					to_converted_form_for_type @type, @output_class
				end

				def to_s
					to_converted_form
				end
			end
		end
	end
end