#include <stdio.h>
#include <stdlib.h>
int main(int argc, char const *argv[])
{
	int i, j, k;
	int maxi, maxj, maxk;
	float max = -99999999999;
	
	for (k = 0; k < 5; ++k){
		char* s = malloc(1000);
		sprintf(s, "./test_hmm new_seq/3B/test/k_15/spoken_mult_5 Digit_HMMs/DG_%d.txt.txt", k+1);
		system(s);
		FILE* F;
		F = fopen("alphaout", "r");
		float f;
		fscanf(F, "%f", &f);
		if(f > max){
			max = f;
			maxi = -1;
			maxj = -1;
			maxk = k;
		}
		fclose(F);
	}

	for (j = 0; j < 5; ++j){
		for (k = 0; k < 5; ++k){
			char* s = malloc(1000);
			sprintf(s, "./test_hmm new_seq/3B/test/k_15/spoken_mult_5 Digit_HMMs/DG_%d_%d.txt", j+1, k+1);
			system(s);
			FILE* F;
			F = fopen("alphaout", "r");
			float f;
			fscanf(F, "%f", &f);
			if(f > max){
				max = f;
				maxi = -1;
				maxj = j;
				maxk = k;
			}
			fclose(F);
		}
	}

	for (i = 0; i < 5; ++i){
		for (j = 0; j < 5; ++j){
			for (k = 0; k < 5; ++k){
				char* s = malloc(1000);
				sprintf(s, "./test_hmm new_seq/3B/test/k_15/spoken_mult_5 Digit_HMMs/DG_%d_%d_%d.txt", i+1, j+1, k+1);
				system(s);
				FILE* F;
				F = fopen("alphaout", "r");
				float f;
				fscanf(F, "%f", &f);
				if(f > max){
					max = f;
					maxi = i;
					maxj = j;
					maxk = k;
				}
				fclose(F);
			}
		}
	}
	printf("\n%d %d %d %f\n", maxi+1, maxj+1, maxk+1, max);
	return 0;
}