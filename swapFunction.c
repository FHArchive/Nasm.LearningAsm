/*
FredHappyface 2020
*/

#include <stdio.h>

int* swap(int ab[]);

int main(){
	int ab[] = {1, 2};
	int* arr_pointer;
	arr_pointer = swap(ab);
	if (arr_pointer == 2){
		printf("Swap worked");
	}
}

int* swap(int ab[]){
	int swapped[] = {ab[1], ab[0]};
	return *swapped;
}
