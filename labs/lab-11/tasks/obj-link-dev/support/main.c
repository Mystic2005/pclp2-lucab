// SPDX-License-Identifier: BSD-3-Clause

extern int set_price(int price);
extern void print_price(void);

extern int qty;
extern void print_quantity(void);

int main(void)
{
	set_price(21);
	print_price();

	qty = 42;
	print_quantity();

	return 0;
}