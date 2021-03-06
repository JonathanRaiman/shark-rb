#ifndef RB_CONVERSIONS_H
#define RB_CONVERSIONS_H
#include "ruby.h"
#include <boost/any.hpp>
#include <boost/format.hpp>
#include <shark/Data/Dataset.h>

typedef VALUE (*rb_method)(...);

VALUE rb_sym_new(const char *);
VALUE method_is_a_directory(VALUE);

// STD and Shark helpers:
std::vector<shark::RealVector>          realvector_to_stdvector(shark::RealVector);
std::vector<double>                     realvector_to_stdvectordouble(shark::RealVector);
std::vector<double>						rb_ary_to_stdvector(VALUE);

// From Ruby
shark::RealVector                       rb_ary_to_1d_realvector(VALUE);
shark::RealMatrix                       rb_ary_to_realmatrix(VALUE);
shark::RealMatrix                       rb_1d_ary_to_realmatrix(VALUE);
std::vector<shark::RealVector>          rb_ary_to_realvector(VALUE);
std::vector<shark::RealMatrix>          rb_ary_to_realmatrices(VALUE);
shark::UnlabeledData<shark::RealVector> rb_ary_to_unlabeleddata(VALUE);

// To Ruby
VALUE realmatrix_to_rb_ary(const shark::RealMatrix&);
VALUE realmatrix_to_rb_ary(const shark::RealMatrix&, bool);
VALUE realvector_to_rb_ary(const shark::RealVector&);
VALUE stdvector_realmatrix_to_rb_ary(const std::vector<shark::RealMatrix>);
VALUE stdvector_realvector_to_rb_ary(const std::vector<shark::RealVector>);

#ifndef RETURN_SIZED_ENUMERATOR_PRE
#define RETURN_SIZED_ENUMERATOR_PRE do { \
	if (!rb_block_given_p()) {
#endif
	   	
#ifndef RETURN_SIZED_ENUMERATOR
#define RETURN_SIZED_ENUMERATOR(obj, argc, argv) \
	return rb_enumeratorize((obj), ID2SYM(rb_frame_this_func()), (argc), (argv));	\
	} \
} while (0)
#endif

#endif