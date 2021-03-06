#include "rb_RNG_Dirichlet.h"
#include "extras/utils/rb_pointer_wrapping.extras"

rb_RNG_Dirichlet::rb_RNG_Dirichlet() : model(shark::Rng::globalRng) {}

shark::Dirichlet< shark::Rng::rng_type > * rb_RNG_Dirichlet::getModel() {
	return &model;
}

extern VALUE rb_optimizer_rng_dirichlet_klass;

VALUE rb_RNG_Dirichlet::rb_class() {
	return rb_optimizer_rng_dirichlet_klass;
}

VALUE method_rb_RNG_Dirichlet_set_alphas (VALUE self, VALUE parameter_1) {
	rb_RNG_Dirichlet * r;
	Data_Get_Struct(self, rb_RNG_Dirichlet, r);
	// Checking whether parameter_1 is a "std::vector<double>"
	if ((TYPE(parameter_1) != T_ARRAY || (RARRAY_LEN(parameter_1) > 0 && TYPE(rb_ary_entry(parameter_1, 0)) != T_FLOAT && TYPE(rb_ary_entry(parameter_1, 0)) != T_FIXNUM)) && (CLASS_OF(parameter_1) != rb_RealVector::rb_class() && CLASS_OF(parameter_1) != rb_RealVectorReference::rb_class() && CLASS_OF(parameter_1) != rb_RealMatrixColumn::rb_class() && CLASS_OF(parameter_1) != rb_RealMatrixRow::rb_class()))
		rb_raise(rb_eArgError, "1st Argument must be an ArrayType (\"RealVector\", \"RealVector\", \"RealMatrixColumn\", \"RealMatrixRow\", \"Array\")");


	// Converting parameter "parameter_1" before it can be used.
	if (TYPE(parameter_1) == T_ARRAY) {
		RealVector parameter_1_converted = rb_ary_to_1d_realvector(parameter_1);
		r->getModel()->alphas(realvector_to_stdvectordouble(parameter_1_converted));
		return self;
	} else if (CLASS_OF(parameter_1) == rb_RealVector::rb_class()) {

		rb_RealVector * parameter_1_converted;
		Data_Get_Struct(parameter_1, rb_RealVector, parameter_1_converted);
		r->getModel()->alphas(realvector_to_stdvectordouble(*(parameter_1_converted->getData())));
		return self;
	} else if (CLASS_OF(parameter_1) == rb_RealVectorReference::rb_class()) {

		rb_RealVectorReference * parameter_1_converted;
		Data_Get_Struct(parameter_1, rb_RealVectorReference, parameter_1_converted);
		r->getModel()->alphas(realvector_to_stdvectordouble(*(parameter_1_converted->getData())));
		return self;
	} else if (CLASS_OF(parameter_1) == rb_RealMatrixColumn::rb_class()) {

		rb_RealMatrixColumn * parameter_1_converted;
		Data_Get_Struct(parameter_1, rb_RealMatrixColumn, parameter_1_converted);
		r->getModel()->alphas(realvector_to_stdvectordouble(*(parameter_1_converted->getData())));
		return self;
	} else if (CLASS_OF(parameter_1) == rb_RealMatrixRow::rb_class()) {

		rb_RealMatrixRow * parameter_1_converted;
		Data_Get_Struct(parameter_1, rb_RealMatrixRow, parameter_1_converted);
		r->getModel()->alphas(realvector_to_stdvectordouble(*(parameter_1_converted->getData())));
		return self;
	}

	return self; // cpp functions require return variable, so if all tests fail "self" is returned.
}

VALUE method_rb_RNG_Dirichlet_get_alphas (VALUE self) {
	rb_RNG_Dirichlet * r;
	Data_Get_Struct(self, rb_RNG_Dirichlet, r);

	return wrap_pointer<rb_RealVector>(rb_RealVector::rb_class(), new rb_RealVector(r->getModel()->alphas()));
}

VALUE method_rb_RNG_Dirichlet_allocate (VALUE klass) {
	return wrap_pointer<rb_RNG_Dirichlet>(rb_RNG_Dirichlet::rb_class(), new rb_RNG_Dirichlet());
}

VALUE method_rb_RNG_Dirichlet_initialize (VALUE self) {
	return self;
}

VALUE method_rb_RNG_Dirichlet_sample (VALUE self) {
	rb_RNG_Dirichlet * r;
	Data_Get_Struct(self, rb_RNG_Dirichlet, r);

	return wrap_pointer<rb_RealVector>(rb_RealVector::rb_class(), new rb_RealVector((*(r->getModel()))()));
}

void Init_rb_RNG_Dirichlet () {
	rb_define_method(rb_RNG_Dirichlet::rb_class(), "alphas=", (rb_method) method_rb_RNG_Dirichlet_set_alphas, 1);
	rb_define_method(rb_RNG_Dirichlet::rb_class(), "alphas", (rb_method) method_rb_RNG_Dirichlet_get_alphas, 0);
	rb_define_alloc_func(rb_RNG_Dirichlet::rb_class(), (rb_alloc_func_t) method_rb_RNG_Dirichlet_allocate);
	rb_define_method(rb_RNG_Dirichlet::rb_class(), "initialize", (rb_method) method_rb_RNG_Dirichlet_initialize, 0);
	rb_define_method(rb_RNG_Dirichlet::rb_class(), "sample", (rb_method) method_rb_RNG_Dirichlet_sample, 0);
}