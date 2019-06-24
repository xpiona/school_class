#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include <ctype.h>

#define Sz0 784
#define Sz1 420
#define Sz2 250
#define Sz3 10

#define	MAX_epoch	10
#define	Number_of_examples_for_train 60000
#define	Num_examples_to_test	10000
#define	Ori_learning_rate	0.20
#define Size_Minibatch 16

double F0[Sz0];
double F1[Sz1];
double F2[Sz2];
double F3[Sz3];
double Softmax[Sz3];

double W1[Sz0][Sz1];
double W2[Sz1][Sz2];
double W3[Sz2][Sz3];
double B1[Sz1];
double B2[Sz2];
double B3[Sz3];

double W1_gradient[Sz0][Sz1];
double W2_gradient[Sz1][Sz2];
double W3_gradient[Sz2][Sz3];
double B1_gradient[Sz1];
double B2_gradient[Sz2];
double B3_gradient[Sz3];

double IN1[Sz1];
double IN2[Sz2];
double IN3[Sz3];

double Delta1[Sz1];
double Delta2[Sz2];
double Delta3[Sz3];

double Sigmoid_deriv1[Sz1];
double Sigmoid_deriv2[Sz2];
double Sigmoid_deriv3[Sz3];

double	learning_rate = Ori_learning_rate;
double	Train_Data[60000][28][28];
int		Train_Label[60000];

double	Test_Data[10000][28][28];
int		Test_Label[10000];

FILE	*fp_accuracy;

double getRandNum(void) {

	double	r;
	int		r2;
	double	sign;

	r = (double)rand();
	r2 = rand();
	if (r2 < RAND_MAX / 2)
		sign = -1.0;
	else
		sign = 1.0;

	return (r / (double)RAND_MAX) * sign;
}  // getRandNum() : end
//
double Compute_sigmoid_F1_from_F0(int i) {
	double res, x = 0;
	int j;
	for (j = 0; j < Sz0; j++)
		x += W1[j][i] * F0[j];
	x += B1[i];
	IN1[i] = x;
	res = 1.0 / (1 + exp(-x));
	return res;
}
//
double Compute_sigmoid_F2_from_F1(int i) {
	double res, x = 0;
	int j;
	for (j = 0; j < Sz1; j++)
		x += W2[j][i] * F1[j];
	x += B2[i];
	IN2[i] = x;
	res = 1.0 / (1 + exp(-x));
	return res;
}
//
double Compute_IN3_from_F2(int i) {
	double x = 0;
	int j;
	for (j = 0; j < Sz2; j++)
		x += W3[j][i] * F2[j];
	x += B3[i];	//add bias
	IN3[i] = x;
	return x;
}
//
void update_parameters_for_minibatch() {
	int i, j, k;
	
	for (i = 0; i < Sz2; i++) {
		for (j = 0; j < Sz3; j++) {
			W3[i][j] = W3[i][j] - learning_rate * W3_gradient[i][j];
		}
	}

	for (i = 0; i < Sz1; i++) {
		for (j = 0; j < Sz2; j++) {
			W2[i][j] = W2[i][j] - learning_rate * W2_gradient[i][j];
		}
	}

	for (i = 0; i < Sz0; i++) {
		for (j = 0; j < Sz1; j++) {
			W1[i][j] = W1[i][j] - learning_rate * W1_gradient[i][j];
		}
	}

	for (k = 0; k < Sz3; k++) {
		B3[k] = B3[k] - learning_rate * B3_gradient[k];
	}

	for (k = 0; k < Sz2; k++) {
		B2[k] = B2[k] - learning_rate * B2_gradient[k];
	}

	for (k = 0; k < Sz1; k++) {
		B1[k] = B1[k] - learning_rate * B1_gradient[k];
	}
}
//
int	init_Parameter() {
	int	i, j;

	// Initialize W1
	for (i = 0; i < Sz0; i++) {
		for (j = 0; j < Sz1; j++) {
			W1[i][j] = getRandNum();
		} // for : j
	} // for :	i

	// Initialize W2 
	for (i = 0; i < Sz1; i++) {
		for (j = 0; j < Sz2; j++) {
			W2[i][j] = getRandNum();
		} // for : j
	} //for :i

	//Initialize W3
	for (i = 0; i < Sz2; i++) {
		for (j = 0; j < Sz3; j++) {
			W3[i][j] = getRandNum();
		} // for : j 
	} // for :	i

	// Initialize Bias of layer 3.
	for (i = 0; i < Sz3; i++) {
		B3[i] = getRandNum();
	} // for :	i

	  // Initialize Bias of layer 2.
	for (i = 0; i < Sz2; i++) {
		B2[i] = getRandNum();
	} // for : i

	// Initialize Bias of layer 1.
	for (i = 0; i < Sz1; i++) {
		B1[i] = getRandNum();
	}  // for :	i

	return 0;
}
//
void forward_compute(int te) {
	int i, j, r, c;
	double denomi;
	j = 0;

	for (r = 0; r < 28; r++) {
		for (c = 0; c < 28; c++) {
			F0[j] = Train_Data[te][r][c] / 255;    // 1 we scale the signal to(0 - 1).
			j++;
		} // for c.
	} // for r.

	for (i = 0; i < Sz1; i++) {
		F1[i] = Compute_sigmoid_F1_from_F0(i);
		Sigmoid_deriv1[i] = F1[i] * (1 - F1[i]); // for i.
	}

	for (i = 0; i < Sz2; i++) {
		F2[i] = Compute_sigmoid_F2_from_F1(i);
		Sigmoid_deriv2[i] = F2[i] * (1 - F2[i]);
	}

	for (i = 0; i < Sz3; i++) {
		F3[i] = Compute_IN3_from_F2(i); //this is the same with 1N3[i]. 
	}

	denomi = 0.0;
	for (i = 0; i < Sz3; i++) {
		denomi = denomi + exp(F3[i]);
	}

	for (i = 0; i < Sz3; i++) {
		Softmax[i] = exp(F3[i]) / denomi;
	}

}
//
void backward_compute(int te) {
	int i, j, k, correct_label=0;
	double temp;

	for (i = 0; i < Sz3; i++) {
		Delta3[i] = Softmax[i];
	}

	correct_label = Train_Label[te];
	Delta3[correct_label] = Delta3[correct_label] - 1;

	for (j = 0; j < Sz2; j++) {
		temp = 0;
		for (k = 0; k < Sz3; k++) {
			temp = temp + Delta3[k] * W3[j][k];
		}
		Delta2[j] = Sigmoid_deriv2[j] * temp;
	}

	for (j = 0; j < Sz1; j++) {
		temp = 0;
		for (k = 0; k < Sz2; k++) {
			temp = temp + Delta2[k] * W2[j][k];
		}
		Delta1[j] = Sigmoid_deriv1[j] * temp;
	}
}
//
void accumulate_gradients_of_parameters(int te) {
	int i, j, k;

	for (i = 0; i < Sz2; i++) {
		for (j = 0; j < Sz3; j++) {
			W3_gradient[i][j] += Delta3[j] * F2[i];
		}
	}

	for (i = 0; i < Sz1; i++) {
		for (j = 0; j < Sz2; j++) {
			W2_gradient[i][j] += Delta2[j] * F1[i];
		}
	}

	for (i = 0; i < Sz0; i++) {
		for (j = 0; j < Sz1; j++) {
			W1_gradient[i][j] += Delta1[j] * F0[i];
		}
	}

	for (k = 0; k < Sz3; k++) {
		B3_gradient[k] += Delta3[k];
	}

	for (k = 0; k < Sz2; k++) {
		B2_gradient[k] += Delta2[k];
	}

	for (k = 0; k < Sz1; k++) {
		B1_gradient[k] += Delta1[k];
	}
}
//
double Do_test() {

	int i, j, r, c, te, max_idx, Label_by_model, correct_cnt = 0;
	double accuracy, max_val, temp;

	for (te = 0; te < Num_examples_to_test; te++) {

		if (te % 1000 == 0)
			printf("Number of test examples tested = %d\n", te);

		for (r = 0; r < 28; r++) {
			for (c = 0; c < 28; c++) {
				F0[r * 28 + c] = Test_Data[te][r][c] / 255;  // scale to 0 -1
			} // for r.
		}


		for (i = 0; i < Sz1; i++) {
			F1[i] = Compute_sigmoid_F1_from_F0(i);
		}


		for (i = 0; i < Sz2; i++) {
			F2[i] = Compute_sigmoid_F2_from_F1(i);
		}

		for (i = 0; i < Sz3; i++) {
			F3[i] = Compute_IN3_from_F2(i);
		}

		temp = 0.0;
		for (i = 0; i < Sz3; i++) {
			temp = temp + exp(F3[i]);
		}

		for (i = 0; i < Sz3; i++) {
			Softmax[i] = exp(F3[i]) / temp;
		}

		max_idx = 0;
		max_val = Softmax[0];
		for (j = 1; j < Sz3; j++) {
			if (max_val < Softmax[j]) {
				max_idx = j;
				max_val = Softmax[j];
			}
		}

		Label_by_model = max_idx;
		if (Label_by_model == Test_Label[te])
			correct_cnt++;
	} // for te.

	accuracy = ((double)correct_cnt) / Num_examples_to_test;

	return accuracy;
}// function Do_test.
//
int	initialize_gradients_before_minibatch() {
	int	i, j;

	// Initialize W1
	for (i = 0; i < Sz0; i++) {
		for (j = 0; j < Sz1; j++) {
			W1_gradient[i][j] = 0;
		} // for : j
	} // for :	i

	// Initialize W2 
	for (i = 0; i < Sz1; i++) {
		for (j = 0; j < Sz2; j++) {
			W2_gradient[i][j] = 0;
		} // for : j
	} //for :i

	//Initialize W3
	for (i = 0; i < Sz2; i++) {
		for (j = 0; j < Sz3; j++) {
			W3_gradient[i][j] = 0;
		} // for : j 
	} // for :	i

	// Initialize Bias of layer 3.
	for (i = 0; i < Sz3; i++) {
		B3_gradient[i] = 0;
	} // for :	i

	  // Initialize Bias of layer 2.
	for (i = 0; i < Sz2; i++) {
		B2_gradient[i] = 0;
	} // for : i

	// Initialize Bias of layer 1.
	for (i = 0; i < Sz1; i++) {
		B1_gradient[i] = 0;
	}  // for :	i

	return 0;
}
//
int Do_train() {
	double Accuracy;
	int start_of_this_minibatch;
	int start_of_next_minibatch;
	int idx_minibatch;
	for (int epoch = 0; epoch < MAX_epoch; epoch++) {
		idx_minibatch = 0;
		do {
			start_of_this_minibatch = idx_minibatch * Size_Minibatch;
			start_of_next_minibatch = start_of_this_minibatch + Size_Minibatch;
			if (!(start_of_next_minibatch - 1 <=Number_of_examples_for_train - 1))
				break;

			initialize_gradients_before_minibatch();
			for (int te = start_of_this_minibatch; te < start_of_next_minibatch; te++) {
				forward_compute(te);
				backward_compute(te);
				accumulate_gradients_of_parameters(te);
				if(te%10000==0)printf("accumulate_gradients_of_parameters for %d\n", te);
			}
			update_parameters_for_minibatch();
			idx_minibatch += 1;
		} while (1);
		printf("\nTesting after epoch = %d has started.\n", epoch);
		Accuracy = Do_test();
		fprintf(fp_accuracy, "After epoch= %d, learning_rate=%f, S-NN Accuracy= %f\n", epoch, learning_rate, Accuracy);
		fflush(fp_accuracy);
		printf("S-NN Accuracy after epoch %3d = %f(stored infile Test_Accuracy.txt)\n\n", epoch, Accuracy);
	}
	return 1;
}
//
void Read_trainging_data() {
	FILE* fp;
	int r, c, te, temp, leng, cp, j;
	char buff_line[1024] = { 0 };
	char num_str[20];
	char debug_line[1024] = { 0 };
	char buffer[100] = { 0 };
	char *ret_fgets;
	int temp_leng = 0;

	fp = fopen("train.txt", "r");
	if (!fp) {
		printf("FILE open failed: train.txt\n"); getchar();
		return 0;
	}

	for (te = 0; te < 60000; te++) {

		if (te % 10000 == 0)
			printf("Training data loading.  te = %d\n", te);

		ret_fgets = fgets(buff_line, 1024, fp);
		if (!ret_fgets) {
			printf("fgets error1.\n");
		}
		leng = strlen(buff_line);
		if (leng != 2) {
			printf("wrong leng of label.\n");
			getchar();
		}
		buff_line[--leng] = '\0';
		Train_Label[te] = atoi(buff_line);


		for (r = 0; r < 28; r++) {
			ret_fgets = fgets(buff_line, 1024, fp);
			if (!ret_fgets) {
				printf("fgets error1.\n");
			}
			leng = strlen(buff_line);
			buff_line[--leng] = '\0';
			cp = 0;
			for (c = 0; c < 28; c++) {
				while (buff_line[cp] == ' ')cp++;
				j = 0;
				while (isdigit(buff_line[cp])) {
					num_str[j] = buff_line[cp];
					j++; cp++;
				}
				num_str[j] = '\0';
				Train_Data[te][r][c] = atof(num_str);

			}
		}
	}
	fclose(fp);

	fp = fopen("test.txt", "r");
	if (!fp) {
		printf("File open failed: test.txt\n");
		return 0;
	}

	for (te = 0; te < 10000; te++) {
		if (te % 2000 == 0)
			printf("Test data loading. te = %d\n", te);

		fscanf_s(fp, "%d", &Test_Label[te]);

		for (r = 0; r < 28; r++) {
			for (c = 0; c < 28; c++) {
				fscanf_s(fp, "%d", &temp);
				Test_Data[te][r][c] = temp;
			}
		}
	}
	fclose(fp);
}
//
int main(void) 
{
	fp_accuracy = fopen("Test_Accuracy.txt", "a");
	if (!fp_accuracy) {
		printf("File open failed: Test_Accuracy.txt\n");
		return 0;
	}
	fprintf(fp_accuracy, "\n\nExperiment of building Supervised NN system has started.\n");
	fprintf(fp_accuracy, "Sz0=%5d, Sz1=%5d, Sz2=%5d, Sz3=%5d, Num_Train_expls=%6d, Num_test_examples=%6d, learning_rate=%f\n, Size_minibatch=%d\n",
		Sz0, Sz1, Sz2, Sz3, Number_of_examples_for_train, Num_examples_to_test, learning_rate, Size_Minibatch);
	fflush(fp_accuracy);

	srand((unsigned)time(NULL));


	Read_trainging_data();
	printf("read training data finish\n\n");

	init_Parameter();
	printf("init_Parameter finish\n\n");

	Do_train();
	printf("Do_train finish\n\n");

	fclose(fp_accuracy);

	return 1;
}
//