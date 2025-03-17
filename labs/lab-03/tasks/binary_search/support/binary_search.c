// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

#include "binary_search.h"

int binary_search(int *v, int len, int dest)
{
	int start = 0;
	int end = len - 1;
	int middle;

	/**
	 * TODO: Implement binary search
	 */

loop:
	if (start <= end) {
		middle = start + (end - start) / 2;

        if (v[middle] == dest)
            goto found;

        if (v[middle] < dest)
            start = middle + 1;

        else
            end = middle - 1;

		goto loop;
	} else {
		goto nofound;
	}

found:
	return middle;
nofound:
	return -1;
}
