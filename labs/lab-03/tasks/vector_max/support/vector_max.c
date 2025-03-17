// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

#include "vector_max.h"

int vector_max(int *v, int len)
{
	int max=-1;
	unsigned int i=0;

loop:
	if (i<len) {
		if (v[i]>max) {
			max = v[i];
			i++;
			goto loop;
		} else {
			i++;
			goto loop;
		}
	}

	return max;
}
