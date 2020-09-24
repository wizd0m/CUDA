#include <stdio.h>
#include <time.h>
#define SIZE	1024

__global__ void VectorAdd(float *a, float *b, float *c, int n)
{
	int i = threadIdx.x;

	if (i < n)
		c[i] = a[i] + b[i];
}

int main()
{
	float *a, *b, *c;
	float *d_a, *d_b, *d_c;
	clock_t start, end;
	double cpu_time_used;

	a = (float *)malloc(SIZE*sizeof(float));
	b = (float *)malloc(SIZE*sizeof(float));
	c = (float *)malloc(SIZE*sizeof(float));

	cudaMalloc( &d_a, SIZE*sizeof(float));
	cudaMalloc( &d_b, SIZE*sizeof(float));
	cudaMalloc( &d_c, SIZE*sizeof(float));

	for( int i = 0; i < SIZE; ++i )
	{
		a[i] = (float) i;
		b[i] = (float) i;
		c[i] = 0.0;
	}

	cudaMemcpy( d_a, a, SIZE*sizeof(float), cudaMemcpyHostToDevice );
	cudaMemcpy( d_b, b, SIZE*sizeof(float), cudaMemcpyHostToDevice );
	cudaMemcpy( d_c, c, SIZE*sizeof(float), cudaMemcpyHostToDevice );

	start = clock();
	VectorAdd<<< 1, SIZE >>>(d_a, d_b, d_c, SIZE);
	end = clock();

	cudaMemcpy( c, d_c, SIZE*sizeof(float), cudaMemcpyDeviceToHost );

	for( int i = 0; i < 10; ++i)
		printf("c[%d] = %f\n", i, c[i]);

	free(a);
	free(b);
	free(c);

	cudaFree(d_a);
	cudaFree(d_b);
	cudaFree(d_c);
	cpu_time_used = ((double) (end - start))/CLOCKS_PER_SEC;
	printf("Time = %f seconds to execute.\n", cpu_time_used);
	return 0;
}
