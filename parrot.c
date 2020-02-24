/*
FredHappyface 2020
*/

#include <stdio.h>

int main(){
	int MAX_LEN = 200;
	char chr_buf[MAX_LEN];
	printf("I am a parrot, input some text: ");
	fgets(chr_buf, MAX_LEN, stdin);
	printf("You entered: %s", chr_buf);
}
