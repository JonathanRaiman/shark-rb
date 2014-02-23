#include "rb_RNG_Weibull.h"
#include "extras/utils/rb_pointer_wrapping.extras"

extern VALUE rb_optimizer_rng_weibull;

VALUE rb_RNG_Weibull::rb_class() {
	return rb_optimizer_rng_weibull;
}

VALUE method_rb_RNG_Weibull_set_alpha (VALUE self, VALUE parameter_1) {
	rb_RNG_Weibull *r;
	Data_Get_Struct(self, rb_RNG_Weibull, r);
	r->getModel()->alpha(parameter_1);
	return self;
}

VALUE method_rb_RNG_Weibull_set_vbeta (VALUE self, VALUE parameter_1) {
	rb_RNG_Weibull *r;
	Data_Get_Struct(self, rb_RNG_Weibull, r);
	r->getModel()->vbeta(parameter_1);
	return self;
}

VALUE method_rb_RNG_Weibull_get_beta (VALUE self) {
	rb_RNG_Weibull *r;
	Data_Get_Struct(self, rb_RNG_Weibull, r);
	return NUM2DBL(r->getModel()->beta());
}

VALUE method_rb_RNG_Weibull_get_alpha (VALUE self) {
	rb_RNG_Weibull *r;
	Data_Get_Struct(self, rb_RNG_Weibull, r);
	return NUM2DBL(r->getModel()->alpha());
}

VALUE method_rb_RNG_Weibull_allocate (VALUE self) {
	rb_RNG_Weibull *r;
	Data_Get_Struct(self, rb_RNG_Weibull, r);
	r->getModel()->();
	return self;
}

VALUE method_rb_RNG_Weibull_p (VALUE self) {
	rb_RNG_Weibull *r;
	Data_Get_Struct(self, rb_RNG_Weibull, r);
	r->getModel()->p();
	return self;
}

VALUE method_rb_RNG_Weibull_sample (VALUE self, VALUE parameter_1) {
	rb_RNG_Weibull *r;
	Data_Get_Struct(self, rb_RNG_Weibull, r);
	return NUM2DBL((*r->getModel())(parameter_1));
}

void Init_rb_RNG_Weibull () {
	rb_define_method(rb_RNG_Weibull::rb_class(), "alpha", (rb_method) method_rb_RNG_Weibull_set_alpha, 1);
	rb_define_method(rb_RNG_Weibull::rb_class(), "vbeta", (rb_method) method_rb_RNG_Weibull_set_vbeta, 1);
	rb_define_method(rb_RNG_Weibull::rb_class(), "beta", (rb_method) method_rb_RNG_Weibull_get_beta, 0);
	rb_define_method(rb_RNG_Weibull::rb_class(), "alpha", (rb_method) method_rb_RNG_Weibull_get_alpha, 0);
	rb_define_alloc_func(rb_RNG_Weibull::rb_class(), (rb_alloc_func_t) method_rb_RNG_Weibull_allocate);
	rb_define_method(rb_RNG_Weibull::rb_class(), "p", (rb_method) method_rb_RNG_Weibull_p, 0);
	rb_define_method(rb_RNG_Weibull::rb_class(), "sample", (rb_method) method_rb_RNG_Weibull_sample, 1);
}