#include <stdio.h>
#include <time.h>
#define SIZE	1024

void VectorAdd(float *a, float *b, float *c, int n)
{
	int i;

	for (i=0; i < n; ++i)
		c[i] = a[i] + b[i];
}

int main()
{
	float *a, *b, *c;
	clock_t start, end;
	double cpu_time_used;

	
	a = (float *)malloc(SIZE * sizeof(float));
	b = (float *)malloc(SIZE * sizeof(float));
	c = (float *)malloc(SIZE * sizeof(float));
	
	for (int i = 0; i < SIZE; ++i)
	{
		a[i] = (float) i;
		b[i] = (float) i;
		c[i] = 0.0;
	}

	start = clock();	
	VectorAdd(a, b, c, SIZE);
	end = clock();

	for (int i = 0; i < 10; ++i)
		printf("c[%d] = %f\n", i, c[i]);

	free(a);
	free(b);
	free(c);

	cpu_time_used = ((double) (end - start))/CLOCKS_PER_SEC;
	printf("Time = %f seconds to execute.\n", cpu_time_used);

	return 0;
}
