#include <stdio.h>

static int a=0;  //global static variable
int b=0;         //global variable

void function(){
static int c=0;    //local static variable
int d=0;           // local variable

printf("a=%d,b=%d,c=%d,d=%d \n",a,b,c,d);
a++;
b++;
c++;
d++;
printf("a=%d,b=%d,c=%d,d=%d \n",a,b,c,d);
}

int main(){
	printf("before increment values\n");
	function();
	
	printf("after increment values\n");
	function();
	
	return 0;
}
//found that local variable reinitialize everytime function is call, and all others retain and stores their values
// output :
// before increment values
// a=0,b=0,c=0,d=0
// a=1,b=1,c=1,d=1
// after increment values
// a=1,b=1,c=1,d=0
// a=2,b=2,c=2,d=1
