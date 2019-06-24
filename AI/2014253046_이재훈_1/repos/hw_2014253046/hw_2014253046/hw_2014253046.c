#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include <ctype.h>

#define Sz0 784
#define Sz1 520
#define Sz2 210
#define Sz3 10

#define	MAX_epoch	10
#define	Number_of_examples_to_use_for_train 60000
#define	Num_examples_to_test	10000
#define	Ori_learning_rate	0.10

double W1[Sz0][Sz1];
double W2[Sz1][Sz2];
double W3[Sz2][Sz3];
double B1[Sz1];
double B2[Sz2];
double B3[Sz3];

double FO[Sz0];
double F1[Sz1];
double F2[Sz2];
double F3[Sz3];
double Softmax[Sz3];

double	IN1[Sz1];
double	IN2[Sz2];
double	IN3[Sz3];

double	Delta1[Sz1];
double	Delta2[Sz2];
double	Delta3[Sz3];

double	Train_Data[60000][28][28];	 // Original train data brought from the file
int		Train_Label_ori[60000];	 // Original train data brought from the file

double	learning_rate = Ori_learning_rate;

double	Test_Data[10000][28][28];
int		Test_Label[10000];

double Sigmoid_deriv1[Sz1];
double Sigmoid_deriv2[Sz2];

FILE	*fp_accuracy;

double getRandNum(void) {

	double	r;
	int		r2;
	double	sign;

	r = (double)rand();
	r2 = rand();
	if (r2 < RAND_MAX/2)
		sign = -1.0;
	else
		sign = 1.0;

	return (r / (double)RAND_MAX) * sign;
}  // getRandNum() : end

double Compute_sigmoid_F1_from_F0(int i) {
	double res, x = 0;
	int j;
	for (j = 0; j < Sz0; j++)
		x += W1[j][i] * FO[j];
	x += B1[i];
	IN1[i] = x;
	res = 1.0 / (1 + exp(-x));
	return res;
}

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

double Compute_IN3_from_F2(int i) {
	double x = 0;
	int j;
	for (j = 0; j < Sz2; j++)
		x += W3[j][i] * F2[j];
	x += B3[i];	//add bias
	IN3[i] = x;
	return x;
}
 
double Do_test() {

	int i, j, r, c, te, max_idx, Label_by_model, correct_cnt = 0;
	double accuracy, max_val, temp;

	for (te = 0; te < Num_examples_to_test; te++) {

		if (te % 1000 == 0)
			printf("Number of test examples tested = %d\n", te);

		for (r = 0; r < 28; r++) {
			for (c = 0; c < 28; c++) {
				FO[r * 28 + c] = Test_Data[te][r][c] / 255;  // scale to 0 -1
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
	if (!fp) { printf("FILE open failed: train.txt\n"); getchar();
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
		Train_Label_ori[te] = atoi(buff_line);
	

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

		fscanf(fp, "%d", &Test_Label[te]);

		for (r = 0; r < 28; r++) {
			for (c = 0; c < 28; c++) {
				fscanf(fp, "%d", &temp);
				Test_Data[te][r][c] = temp;
			}
		}
	}
	fclose(fp);
}

int Do_train() {
	int te, i, j, k, epoch, r, c, correct_label;
	double denomi, temp, Accuracy;

	for (epoch = 0; epoch < MAX_epoch; epoch++) {
		for (te = 0; te < Number_of_examples_to_use_for_train; te++) {
			if (te % 2000 == 1)
				printf("Train Supervised NN: At epoch %d. Ing_rate= %f, Training example number = %d\n", epoch, learning_rate, te);
			//////////////////////// FORWARD COMPUTATION STARTS HERE.//////////////////////////////////////
			j = 0;

			for (r = 0; r < 28; r++) {
				for (c = 0; c < 28; c++) {
					FO[j] = Train_Data[te][r][c]/255;    // 1 we scale the signal to(0 - 1).
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
				Delta3[i] = exp(F3[i]) / denomi;
			}
			correct_label = Train_Label_ori[te]; // get the correct label for this train example be used.Delta3[correct_label] 
			Delta3[correct_label] = Delta3[correct_label] - 1;

			// Compute delta for F2 units.
			for (j = 0; j < Sz2; j++) {
				temp = 0;
				for (k = 0; k < Sz3; k++) {
					temp = temp + Delta3[k] * W3[j][k];
				}
				Delta2[j] = Sigmoid_deriv2[j] * temp;
			}
			// Compute delta for Fl units.
			for (j = 0; j < Sz1; j++) {
				temp = 0;
				for (k = 0; k < Sz2; k++) {
					temp = temp + Delta2[k] * W2[j][k];
				}
				Delta1[j] = Sigmoid_deriv1[j] * temp;
			}

			for (i = 0; i < Sz2; i++) {
				for (j = 0; j < Sz3; j++) {
					temp = learning_rate * (Delta3[j] * F2[i]);
					W3[i][j] = W3[i][j] - temp;
				}
			}
			// Update the parameters W2.

			for (i = 0; i < Sz1; i++) {
				for (j = 0; j < Sz2; j++) {
					temp = learning_rate * (Delta2[j] * F1[i]);
					W2[i][j] = W2[i][j] - temp;
				}
			}
			// Update the parameters W1.

			for (i = 0; i < Sz0; i++) {
				for (j = 0; j < Sz1; j++) {
					temp = learning_rate * (Delta1[j] * FO[i]);
					W1[i][j] = W1[i][j] - temp;
				}
			}
			// Update 83 parameters.
			for (k = 0; k < Sz3; k++) {
				temp = learning_rate * Delta3[k];
				B3[k] = B3[k] - temp;
			}

			for (k = 0; k < Sz2; k++) {
				temp = learning_rate * Delta2[k];
				B2[k] = B2[k] - temp;
			}
			// Update 81 parameters.


			for (k = 0; k < Sz1; k++) {
				temp = learning_rate * Delta1[k];
				B1[k] = B1[k] - temp;
			}
			//
			for (k = 0; k < Sz3; k++) {
				temp = learning_rate * Delta3[k];
				B3[k] = B3[k] - temp;
			}

			// Update 82 parameters.

			for (k = 0; k < Sz2; k++) {
				temp = learning_rate * Delta2[k];
				B2[k] = B2[k] - temp;
			}
			// Update 81 parameters.

			for (k = 0; k < Sz1; k++) {
				temp = learning_rate * Delta1[k];
				B1[k] = B1[k] - temp;
			}
		}

		printf("\nSupervised NN system Testing after epoch= %d has started.\n", epoch);
		Accuracy = Do_test();
		fprintf(fp_accuracy, "After epoch= %d, Ing_rate= %f,	S-NN Accuracy = %f\n", epoch, learning_rate, Accuracy);
		fflush(fp_accuracy);
		printf("S-NN Accuracy after epoch %3d = %f (stored in file Test_Accuracy.txt)\n\n", epoch, Accuracy);
	} //for epoch.
	return 1;
}

int main(void)
{
	fp_accuracy = fopen("Test_Accuracy.txt", "a");
	if (!fp_accuracy) {
		printf("File open failed: Test_Accuracy.txt\n");
		return 0;
	}
	fprintf(fp_accuracy, "\n\nExperiment of building Supervised NN system has started.\n");
	fprintf(fp_accuracy, "Sz0=%5d, Sz1=%5d, Sz2=%5d, Sz3=%5d, Num_Train_expls=%6d, Num_test_examples=%6d, learning_rate=%f\n",
		Sz0, Sz1, Sz2, Sz3, Number_of_examples_to_use_for_train, Num_examples_to_test, learning_rate);
	fflush(fp_accuracy);

	srand((unsigned)time(NULL));


	Read_trainging_data();
	printf("read training data finish\n\n");

	init_Parameter();
	printf("init parameter finish\n\n");

	Do_train();
	printf("Do_train finish\n\n");

	fclose(fp_accuracy);

	return 1;
}


