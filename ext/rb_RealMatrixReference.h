#ifndef RB_REALMATRIX_REFERENCE_H
#define RB_REALMATRIX_REFERENCE_H

#include "ruby.h"
#include <boost/any.hpp>
#include <boost/format.hpp>
#include <shark/Data/Dataset.h>
#include "rb_conversions.h"
#include "rb_RealVector.h"
#include "rb_RealMatrix.h"

using namespace std;
using namespace shark;
class rb_RealMatrixReference {
	public:
		rb_RealMatrixReference(RealMatrix const &);
		rb_RealMatrixReference();
		void fill(double);
		RealMatrix& data;
		RealVector get_row(int);
		RealVector get_column(int);

};

void Init_RealMatrixReference ();

#endif