/*
FredHappyface 2020
*/

#include <stdio.h>
int printReg(long register_val);

/*
Test the printReg function. Should print:
0b1010
0b1100100
0b1111101000
*/
int main(){
	printReg(10);
	printReg(100);
	printReg(1000);
}

/*
Print a 'register' as a binary value
*/
int printReg(long register_val){
	printf("0b");
	int flag_start = 0;
	for(int shift = 63; shift >= 0 ; shift--){
		int bit = register_val >> shift & 1;
		if(bit){
			flag_start = 1;
		}
		if(flag_start){
			printf("%d", bit);
		}
	}
	printf("\n");
}
